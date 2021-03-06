!
Subroutine  OPEN_geo(geofile,NCID)
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

   CHARACTER*120 ::  geofile
   integer :: NCID
   integer :: status
!
   STATUS=NF_OPEN(trim(geofile),0,NCID)
!
   IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

end Subroutine OPEN_geo
!
Subroutine  CLOSE_geo(NCID)
! 
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

   integer :: NCID
   integer :: status
! 
   STATUS=NF_CLOSE(NCID)
! 
   IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

end Subroutine CLOSE_geo


Subroutine  GET_geo_sngl_geo(NCID,mscNlon,mscNlat,mscValueLAT,mscValueLON)
!
!  Author: Ming Hu, ESRL/GSD
!  
!  First written: 12/16/2007.
!
!  IN:
!     mscNlon
!     mscNlan
!     NCID
!  out:
!     mscValueLAT
!     mscValueLON
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

  INTEGER ::   mscNlon   ! number of longitude of mosaic data
  INTEGER ::   mscNlat   ! number of latitude of mosaic data

  INTEGER ::  NCID, STATUS, MSLATID,MSLONID

  INTEGER ::   NDIMS
  PARAMETER (NDIMS=3)                  ! number of dimensions
  INTEGER START(NDIMS), COUNT(NDIMS)

  REAL ::   mscValueLAT(mscNlon,mscNlat,1)
  REAL ::   mscValueLON(mscNlon,mscNlat,1)
  INTEGER :: i,j

  START(1)=1
  START(2)=1
  START(3)=1
  COUNT(1)=mscNlon
  COUNT(2)=mscNlat
  COUNT(3)=1

  STATUS = NF_INQ_VARID (NCID, 'XLAT_M', MSLATID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_GET_VARA_REAL (NCID, MSLATID, START, COUNT, mscValueLAT)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_VARID (NCID, 'XLONG_M', MSLONID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_GET_VARA_REAL (NCID, MSLONID, START, COUNT, mscValueLON)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

end subroutine GET_geo_sngl_geo

Subroutine  GET_DIM_ATT_geo(geosngle,LONLEN,LATLEN)
!
!  Author: Ming Hu, CAPS. University of Oklahma.
!  
!  First written: 12/16/2007.
!
!   New verison of geo file
!
!  IN:
!     geosngle : name of mosaic file
!  OUT
!     LONLEN
!     LATLEN
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

  CHARACTER*120    geosngle

  INTEGER ::   mscNlon   ! number of longitude of mosaic data
  INTEGER ::   mscNlat   ! number of latitude of mosaic data

  INTEGER ::  NCID, STATUS
  INTEGER ::  LONID, LATID
  INTEGER ::  LONLEN, LATLEN

  STATUS = NF_OPEN(trim(geosngle), 0, NCID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_DIMID(NCID, 'west_east', LONID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMID(NCID, 'south_north', LATID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_DIMLEN(NCID, LONID, LONLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMLEN(NCID, LATID, LATLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_CLOSE(NCID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS) 

END SUBROUTINE GET_DIM_ATT_geo

SUBROUTINE HANDLE_ERR_geo(STATUS)
     INCLUDE 'netcdf.inc'
     INTEGER STATUS
     IF (STATUS .NE. NF_NOERR) THEN
       PRINT *, NF_STRERROR(STATUS)
       STOP 'Stopped'
     ENDIF
END SUBROUTINE HANDLE_ERR_geo

Subroutine  GET_DIM_ATT_fv3sar(geosngle,LONLEN,LATLEN)
!
!  Author: Ming Hu, GSL.
!  
!  First written: 04/06/2019.
!
!  IN:
!     geosngle : name of mosaic file
!  OUT
!     LONLEN
!     LATLEN
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

  CHARACTER*120    geosngle

  INTEGER ::   mscNlon   ! number of longitude of mosaic data
  INTEGER ::   mscNlat   ! number of latitude of mosaic data

  INTEGER ::  NCID, STATUS
  INTEGER ::  LONID, LATID
  INTEGER ::  LONLEN, LATLEN

  STATUS = NF_OPEN(trim(geosngle), 0, NCID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_DIMID(NCID, 'grid_xt', LONID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMID(NCID, 'grid_yt', LATID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_DIMLEN(NCID, LONID, LONLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMLEN(NCID, LATID, LATLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_CLOSE(NCID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS) 

END SUBROUTINE GET_DIM_ATT_fv3sar

Subroutine  GET_DIM_ATT_fv3sar_sfcdata(geosngle,LONLEN,LATLEN,LEVLEN)
!
!  Author: Ming Hu, GSL.
!  
!  First written: 04/06/2019.
!
!  IN:
!     geosngle : name of mosaic file
!  OUT
!     LONLEN
!     LATLEN
!     LEVLEN
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

  CHARACTER*120    geosngle

  INTEGER ::   mscNlon   ! number of longitude of mosaic data
  INTEGER ::   mscNlat   ! number of latitude of mosaic data
  INTEGER ::   mscNlev   ! number of latitude of mosaic data

  INTEGER ::  NCID, STATUS
  INTEGER ::  LONID, LATID, LEVID
  INTEGER ::  LONLEN, LATLEN, LEVLEN

  STATUS = NF_OPEN(trim(geosngle), 0, NCID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_DIMID(NCID, 'xaxis_1', LONID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMID(NCID, 'yaxis_1', LATID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMID(NCID, 'zaxis_1', LEVID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_DIMLEN(NCID, LONID, LONLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMLEN(NCID, LATID, LATLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_INQ_DIMLEN(NCID, LEVID, LEVLEN)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_CLOSE(NCID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS) 

END SUBROUTINE GET_DIM_ATT_fv3sar_sfcdata

Subroutine  GET_geo_sngl_fv3sar(NCID,mscNlon,mscNlat,mscValueLAT,mscValueLON)
!
!  Author: Ming Hu, ESRL/GSD
!  
!  First written: 12/16/2007.
!
!  IN:
!     mscNlon
!     mscNlan
!     NCID
!  out:
!     mscValueLAT
!     mscValueLON
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

  INTEGER ::   mscNlon   ! number of longitude of mosaic data
  INTEGER ::   mscNlat   ! number of latitude of mosaic data

  INTEGER ::  NCID, STATUS, MSLATID,MSLONID 

  INTEGER ::   NDIMS
  PARAMETER (NDIMS=3)                  ! number of dimensions
  INTEGER START(NDIMS), COUNT(NDIMS)

  REAL ::   mscValueLAT(mscNlon,mscNlat,1)
  REAL ::   mscValueLON(mscNlon,mscNlat,1)
  INTEGER :: i,j

  START(1)=1
  START(2)=1
  START(3)=1
  COUNT(1)=mscNlon
  COUNT(2)=mscNlat
  COUNT(3)=1

  STATUS = NF_INQ_VARID (NCID, 'grid_latt', MSLATID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_GET_VARA_REAL (NCID, MSLATID, START, COUNT, mscValueLAT)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_VARID (NCID, 'grid_lont', MSLONID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_GET_VARA_REAL (NCID, MSLONID, START, COUNT, mscValueLON)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

end subroutine GET_geo_sngl_fv3sar

Subroutine  GET_geo_sngl_fv3sar_xv(NCID,mscNlon,mscNlat,mscValueXland,mscValueVtyp)
!
!  Author: Ming Hu, ESRL/GSD
!  
!  First written: 12/16/2007.
!
!  IN:
!     mscNlon
!     mscNlan
!     NCID
!  out:
!     mscValueXland
!     mscValueVtyp 
!
  IMPLICIT NONE

  INCLUDE 'netcdf.inc'

  INTEGER ::   mscNlon   ! number of longitude of mosaic data
  INTEGER ::   mscNlat   ! number of latitude of mosaic data

  INTEGER ::  NCID, STATUS, MSXLANDID,MSVTYPID

  INTEGER ::   NDIMS
  PARAMETER (NDIMS=3)                  ! number of dimensions
  INTEGER START(NDIMS), COUNT(NDIMS)

  REAL ::   mscValueXland(mscNlon,mscNlat,1)
  REAL ::   mscValueVtyp(mscNlon,mscNlat,1)
  INTEGER :: i,j

  START(1)=1
  START(2)=1
  START(3)=1
  COUNT(1)=mscNlon
  COUNT(2)=mscNlat
  COUNT(3)=1

  STATUS = NF_INQ_VARID (NCID, 'slmsk', MSXLANDID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_GET_VARA_REAL (NCID, MSXLANDID, START, COUNT, mscValueXland)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

  STATUS = NF_INQ_VARID (NCID, 'vtype', MSVTYPID)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)
  STATUS = NF_GET_VARA_REAL (NCID, MSVTYPID, START, COUNT, mscValueVtyp)
  IF (STATUS .NE. NF_NOERR) CALL HANDLE_ERR_geo(STATUS)

end subroutine GET_geo_sngl_fv3sar_xv
