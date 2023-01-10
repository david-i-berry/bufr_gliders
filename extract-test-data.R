# set TZ
Sys.setenv(tz="UTC")
# load libraries
library(ncdf4)
library(jsonlite)
library(httr)

# download (if requireed) and open file
filepath <- "/local/test-data/input/Melonhead_496_R.nc"
if( ! file.exists(filepath) ){
    GET( url = "https://linkedsystems.uk/erddap/files/Public_Glider_Data_0711/Melonhead_20180207/Melonhead_496_R.nc",
         write_disk("/local/test-data/Melonhead_496_R.nc", overwrite = TRUE) )
}
ncin <- nc_open(filepath)

# pick one profile and set indices
start <- 3557
phase1 <- 0:66 + start
phase2 <- 67:215 + start
phase3 <- 216:305 + start
surface_end <- 56

# read the data we want,
glider_model <- ncvar_get(ncin,'PLATFORM_TYPE')
serial_number <- ncvar_get(ncin,'GLIDER_SERIAL_NO')
surface_datetime <- ncvar_get(ncin,'TIME_GPS')
surface_datetime <- as.POSIXct(surface_datetime, origin = '1970-01-01')
lat_gps <- ncvar_get(ncin,'LATITUDE_GPS')
lon_gps <- ncvar_get(ncin,'LONGITUDE_GPS')
lon <- ncvar_get(ncin,'LONGITUDE')
lat <- ncvar_get(ncin,'LATITUDE')
datetime <- ncvar_get(ncin,"TIME")
datetime <- as.POSIXct(datetime, origin = '1970-01-01')
depth <- ncvar_get(ncin,'GLIDER_DEPTH')
pressure <- ncvar_get(ncin,"PRES")
temperature <- ncvar_get(ncin,'TEMP')
conductivity <- ncvar_get(ncin,'CNDC')
salinity <- ncvar_get(ncin,'PSAL')
density <- ncvar_get(ncin,'SIGMA_THETA')
# close the file
nc_close(ncin)

# now sequence to encode
wsi_series <- NA
wsi_issuer <- NA
wsi_issue_number <- NA
wsi_local_identifier <- NA
wmo_id <- NA
station_name <- "MELONHEAD"
agency <- NA # "UEA" not in code table
data_system <- NA # code table
glider_model <- glider_model
serial_number <- serial_number

time_significance <- c(25,2,NA)

surface_year <- as.numeric(format.POSIXct(surface_datetime[surface_end],'%Y'))
surface_month <- as.numeric(format.POSIXct(surface_datetime[surface_end],'%m'))
surface_day <- as.numeric(format.POSIXct(surface_datetime[surface_end],'%d'))

surface_hour <- as.numeric(format.POSIXct(surface_datetime[surface_end],'%H'))
surface_minute <- as.numeric(format.POSIXct(surface_datetime[surface_end],'%M'))
surface_second <- as.numeric(format.POSIXct(surface_datetime[surface_end],'%S'))

surface_lat <- round(lat_gps[surface_end],5)
surface_lon <- round(lon_gps[surface_end],5)
heading <- NA
anemometer_type <- c(2,NA)
wind_speed <- NA
wind_direction <- NA
surface_current_speed <- NA
surface_current_direction <- NA

end_datetime <- max(datetime[phase3])
end_year <- as.numeric(format.POSIXct(end_datetime,'%Y'))
end_month <- as.numeric(format.POSIXct(end_datetime,'%m'))
end_day <- as.numeric(format.POSIXct(end_datetime,'%d'))

end_hour <- as.numeric(format.POSIXct(end_datetime,'%H'))
end_minute <- as.numeric(format.POSIXct(end_datetime,'%M'))
end_second <- as.numeric(format.POSIXct(end_datetime,'%S'))

dive_duration <- round(as.numeric(difftime(max(datetime[phase3]), min(datetime[phase1]), units = "min")))
mean_lat <- round(mean( lat[c(phase1, phase2, phase3)]),5)
mean_lon <- round(mean( lon[c(phase1, phase2, phase3)]),5)
mean_current_speed <- NA
mean_current_direction <- NA

profile_number <- 0
profile_uid <- "MYUUID-1234"
delayed_replicator <- c(3,67,149,90)
profile_direction <- c(1,2,0)
year <- as.numeric(format.POSIXct(datetime[c(phase1,phase2,phase3)],'%Y'))
month <- as.numeric(format.POSIXct(datetime[c(phase1,phase2,phase3)],'%m'))
day <- as.numeric(format.POSIXct(datetime[c(phase1,phase2,phase3)],'%d'))
hour <- as.numeric(format.POSIXct(datetime[c(phase1,phase2,phase3)],'%H'))
minute <- as.numeric(format.POSIXct(datetime[c(phase1,phase2,phase3)],'%M'))
second <- as.numeric(format.POSIXct(datetime[c(phase1,phase2,phase3)],'%S'))
profile_lat <- round(lat[c(phase1,phase2,phase3)],5)
profile_lon <- round(lon[c(phase1,phase2,phase3)],5)
gtspp_quality_qualifiers <- rep( c(20, 13, 10, 11, 25, 12, 26), times = length(c(phase1,phase2,phase3)))
gtspp_quality_flags <- rep(c(NA, NA, NA, NA, NA, NA, NA), times = length(c(phase1,phase2,phase3)))
profile_depth <- depth[c(phase1,phase2,phase3)]
profile_pressure <- pressure[c(phase1,phase2,phase3)]*1000000 # convert dbar to Pa
profile_temperature <- temperature[c(phase1,phase2,phase3)] + 273.15
profile_conductivity <- conductivity[c(phase1,phase2,phase3)]
profile_salinity <- salinity[c(phase1,phase2,phase3)] # assuming equivalence between 1 ppt and 1 psu
profile_density <- density[c(phase1,phase2,phase3)] # kg m-3

headers <- list(
  "inputDelayedDescriptorReplicationFactor" = c(3),
  "inputExtendedDelayedDescriptorReplicationFactor" = c(67,149,90),
  "edition" = 4,
  "masterTableNumber" = 0,
  "bufrHeaderCentre" = 0,
  "bufrHeaderSubCentre" = 0,
  "updateSequenceNumber" = 0,
  "dataCategory" = 0,
  "internationalDataSubCategory" = 6,
  "dataSubCategory" = 0,
  "masterTablesVersionNumber" = 39,
  "typicalYear" = 2018,
  "typicalMonth" = 2,
  "typicalDay" = 7,
  "typicalHour" = 23,
  "typicalMinute" = 23,
  "typicalSecond" = 42,
  "numberOfSubsets" = 1,
  "observedData" = 1,
  "compressedData" = 0,
  "unexpandedDescriptors" = c(315012)
)

# convert to list, using eccodes keys
data <- list(
  "wigosIdentifierSeries" = NA,
  "wigosIssuerOfIdentifier" = NA,
  "wigosIssueNumber" = NA,
  "wigosLocalIdentifierCharacter" = NA,
  # change data width
  "marineObservingPlatformIdentifier" = NA,
  # cancel change data width
  "longStationName" = trimws(station_name),
  "agencyInChargeOfOperatingObservingPlatform" = NA,
  "dataCollectionLocationSystem" = NA,
  "observingPlatformManufacturerModel" = trimws(glider_model),
  "observingPlatformManufacturerSerialNumber" = trimws(serial_number),
  "timeSignificance" = c(25,2,NA),
  "year" = c(surface_year, end_year, year),
  "month" = c(surface_month, end_month, month),
  "day" = c(surface_day, end_day, day),
  "hour" = c(surface_hour, end_hour, hour),
  "minute" = c(surface_minute, end_minute, minute),
  "second" = c(surface_second, end_second, second),
  "latitude" = c(surface_lat, mean_lat, profile_lat),
  "longitude" = c(surface_lon, mean_lon, profile_lon),
  "aircraftTrueHeading" = NA,
  "anemometerType" = c(2,NA),
  "windSpeed" = NA,
  "windDirection" = NA,
  "speedOfSeaSurfaceCurrent" = NA,
  "seaSurfaceCurrentDirection" = NA,
  "timeSignificance" = NA,
  "timePeriod" = NA,
  "speedOfCurrent" = NA,
  "currentDirection" = NA,
  "profileNumber" = NA,
  "uniqueIdentifierForProfile" = NA,
  # "delayedDescriptorReplicationFactor" = 3,
  "directionOfProfile" = profile_direction,
  # "extendedDelayedDescriptorReplicationFactor" = c(67,149,90),
  "qualifierForGtsppQualityFlag" = gtspp_quality_qualifiers,
  "globalGtsppQualityFlag" = gtspp_quality_flags,
  "depthBelowWaterSurface" = profile_depth,
  "oceanographicWaterPressure" = profile_pressure,
  "oceanographicWaterTemperature" = profile_temperature,
  "oceanographicWaterConductivity" = profile_conductivity,
  "salinity" = profile_salinity,
  "seawaterPotentialDensity" = profile_density
)

output <- list(
  "headers" = headers,
  "data" = data
)

# now write to json
writeLines(toJSON( output, pretty=4, digits=NA, na = 'null', auto_unbox = TRUE), '/local/test-data/output/melonhead.json')

