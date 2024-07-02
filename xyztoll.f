c  Converts x,y,z, unit vector, to lat, long
c  Standard input/output
      dimension x(3)
c
       do 1500 i=1,10000000
        read (*,*, end=1600) x(1),x(2),x(3)
          call xyzll(rlat,rlong,x)
          print   '(2f10.4)', rlat,rlong
c
 1500 continue
 1600 stop
      end
c____________________________________________________
      subroutine xyzll(rlat,rlong,x)
c$$$$ calls no other routines
c  Maps unit vector x into lat, long (degrees)
	dimension x(3)
	data drad/57.29577951/
	rlat=drad*atan2(x(3),sqrt(x(2)**2 +x(1)**2))
	rlong =drad*atan2(x(2),x(1))
	return
	end
c_____________________________________________________________
