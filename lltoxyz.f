c  Converts lat, long to x,y,z, unit vector
c  Standard input/output
      dimension x(3)
c
       do 1500 i=1,100000
        read (*,*, end=1600) rlat,rlong
          call llxyz(rlat,rlong,x)
          print   '(3f10.4)', x(1),x(2),x(3)
c
 1500 continue
 1600 stop
      end
c____________________________________________________
      subroutine llxyz(rlat,rlong,x)
c$$$$ calls no other routines
c  Maps lat, long (degrees) into unit vector x
	dimension x(3)
	data drad/57.29577951/
	x(3)=sin(rlat/drad)
	x(2)=cos(rlat/drad)*sin(rlong/drad)
	x(1)=cos(rlat/drad)*cos(rlong/drad)
	return
	end
c_____________________________________________________________
