# PP controller

# to define vehicle state, including course, distance to centerline, position X and Y in global coordiante, yaw angle and target point position
class vehilcestates:
    def __init__(self,s,d,pX,pY,psi,targetX,targetY):
        self.s=s
        self.d=d
        self.pX=pX
        self.pY=pY
        self.psi=psi
        self.targetX=targetX
        self.targetY=targetY

# to define centerline information, including centerline, left and right edge waypoints, course, curvature (kappa) and interplation 
class ctline:
    def __init__(self,cpx,cpy,lpx,lpy,rpx,rpy,course,kap,interpX,interpY):
        self.cpx=cpx
        self.cpy=cpy
        self.lpx=lpx
        self.lpy=lpy
        self.rpx=rpx
        self.rpy=rpy
        self.course=course
        self.kap=kap
        self.interpX=interpX
        self.interpY=interpY

# to define reference trajectory informatoin, similar to centline with velocity
class waypoint:
    def __init__(self,course,pX,pY,Vx,Vy,interpX,interpY,interpVx,interpVy):
        self.course=course
        self.pX=pX
        self.pY=pY
        self.Vx=Vx
        self.Vy=Vy
        self.interpX=interpX
        self.interpY=interpY
        self.interpVx=interpVx
        self.interpVy=interpVy

# read referenceline information from csv file
def readreferenceline(referenceline,readpath):     
    f=open (readpath,'r')
    f_csv = csv.reader(f)
    for row0 in f_csv:
        row=list(map(lambda x: float(x), row0))
        referenceline.course.append(row[0])
        referenceline.pX.append(row[1])
        referenceline.pY.append(row[2])
        referenceline.Vx.append(row[3])
        referenceline.Vy.append(row[4])
    f.close()

# read centerline information from csv file
def readcenterline(centerline, readpath='trackdata-3.csv'):
    f=open (readpath,'r')
    f_csv = csv.reader(f)
    for row0 in f_csv:
        row=list(map(lambda x: float(x), row0))
        centerline.cpx.append(row[0])
        centerline.cpy.append(row[1])
        centerline.lpx.append(row[2])
        centerline.lpy.append(row[3])
        centerline.rpx.append(row[4])
        centerline.rpy.append(row[5])
        centerline.course.append(row[6])
        centerline.kap.append(row[7])
    f.close()

# interpolate the centline
def interp(centerline):
    Cx=centerline.cpx
    Cy=centerline.cpy
    course=centerline.course
    # input centerline information and get interpolation function
    centerline.interpX=interp1d(course,Cx,kind='cubic')
    centerline.interpY=interp1d(course,Cy,kind='cubic')
    return centerline

# interpolate the referenceline
def interp_referenceline(referenceline):
    referenceline.interpX=interp1d(referenceline.course,referenceline.pX,kind='cubic')
    referenceline.interpY=interp1d(referenceline.course,referenceline.pY,kind='cubic')
    referenceline.interpVx=interp1d(referenceline.course,referenceline.Vx,kind='cubic')
    referenceline.interpVy=interp1d(referenceline.course,referenceline.Vy,kind='cubic')
    return referenceline

# predict target point in centerline (not used if adopt referenceline)
def target_point(dist,centerline,states):
    # run along the course and find the target point
    new_course=states.s+dist
    if new_course>max(centerline.course):
        new_course=new_course-max(centerline.course)+1
    states.targetX=centerline.interpX(new_course)
    states.targetY=centerline.interpY(new_course)
    return centerline, states

# predict target point in referenceline
def target_point_reference(dist,states,referenceline):
    new_course=states.s+dist
    if new_course>max(referenceline.course):
        new_course=new_course-max(referenceline.course)+1
    elif new_course<min(referenceline.course):
        new_course=min(referenceline.course)+0.1
    states.targetX=referenceline.interpX(new_course)
    states.targetY=referenceline.interpY(new_course)
    return states

# compute predicting yaw error
def get_alp(states):
    alpha=math.atan2(states.targetX-states.pX, states.targetY-states.pY)-states.psi
    #print('alp: '+str(alpha/np.pi*180))
   # print('psi: '+str(states.psi/np.pi*180))
    return alpha

# for velocity controller (throttle/ brake)
def target_velocity(states,referenceline):
    new_course=states.s
    if new_course>max(referenceline.course):
        new_course-=max(referenceline.course)+1
    elif new_course<min(referenceline.course):
        new_course=min(referenceline.course)+0.1
    idealVx=referenceline.interpVx(new_course)*3.6+4
    return idealVx

# initialize centerline and referenceline information
def initialize():
    centerline=ctline(cpx=[],cpy=[],lpx=[],lpy=[],rpx=[],rpy=[],course=[],kap=[],interpX=[],interpY=[])
    states=vehilcestates(s=0,d=0,pX=0,pY=0,psi=0,targetX=0,targetY=0)
    referenceline=waypoint(course=[],pX=[],pY=[],Vx=[],Vy=[],interpX=[],interpY=[],interpVx=[],interpVy=[])
    readcenterline(centerline,'/home/mscgts/Documents/example_connection/trackdata-3.csv')
    readreferenceline(referenceline,'/home/mscgts/Documents/example_connection/referenceline2.csv')
    interp(centerline)
    interp_referenceline(referenceline)
    return centerline,states,referenceline
    
centerline,states,referenceline=initialize()    


k=0.2 # lookahead coefficient
L0=5.0 # fixed lookahead distance
L=1.847699+2.0683  # wheel base of vehicle

def test_policy2(ob,centerline,states,referenceline):
    #--------------------------observe states-------------------------------
    Vx=ob[0]
    d=ob[1]
    ang=ob[2]
    states.s=ob[17]
    states.psi=ob[15][1]
    states.pX=ob[16][0]
    states.pY=ob[16][2]
    time=ob[20]/1000
    
    #----------------------------steer-----------------------------------------
   # lookahead distance, 3.6 means from km/h to m/s
   Lf=L+k*Vx/3.6
    #if use centerline as refernece use this code
#     centerline, states=target_point(Lf,centerline,states)
    # if use human trajectory as reference use this code
    states=target_point_reference(Lf,states,referenceline)
    alpha=get_alp(states)
    steer=-math.atan2(2*2.0*L*math.sin(alpha),Lf)*1.1
        
    # -----------------------throttle------------------------------------------
    # ideal velocity from human trajectory, or user can customize their own velocity profile
    idealVx=target_velocity(states,referenceline)
    
    # a simple propotional controller with  dead zone
    fb=Vx-idealVx
    gap=2;
    if abs(fb)<gap:
          thr=-fb/gap
    else:
          thr=-np.sign(fb)
        
    # -----------------------return--------------------------------------------
    return [steer,thr,states]
