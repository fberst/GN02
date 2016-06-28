#!/bin/bash
if [ -z ${XCSoarData} ]; then
  XCSoarData="/home/rbe/XCSoarData/"
fi
# Check if XCSoarData directory exists, if not than create it
if [ ! -d $XCSoarData ] ; then 
  mkdir $XCSoarData ; 
fi

# change to the XCSoarData directory
cd $XCSoarData

# download waypoint files
wget http://download.xcsoar.org/waypoints/Afghanistan.cup .
wget http://download.xcsoar.org/waypoints/Albania.cup .
wget http://download.xcsoar.org/waypoints/Algeria.cup .
wget http://download.xcsoar.org/waypoints/Argentina.cup .
wget http://download.xcsoar.org/waypoints/Australia.cup .
wget http://download.xcsoar.org/waypoints/Austria.cup .
wget http://download.xcsoar.org/waypoints/Belgium.cup .
wget http://download.xcsoar.org/waypoints/Bolivia.cup .
wget http://download.xcsoar.org/waypoints/Bosnia%20And%20Herzegovina.cup .
wget http://download.xcsoar.org/waypoints/Botswana.cup .
wget http://download.xcsoar.org/waypoints/Brazil.cup .
wget http://download.xcsoar.org/waypoints/Bulgaria.cup .
wget http://download.xcsoar.org/waypoints/Canada.cup .
wget http://download.xcsoar.org/waypoints/Chile.cup .
wget http://download.xcsoar.org/waypoints/China.cup .
wget http://download.xcsoar.org/waypoints/Croatia.cup .
wget http://download.xcsoar.org/waypoints/Cyprus.cup .
wget http://download.xcsoar.org/waypoints/Czech%20Republic.cup .
wget http://download.xcsoar.org/waypoints/Denmark.cup .
wget http://download.xcsoar.org/waypoints/Dominican%20Republic.cup .
wget http://download.xcsoar.org/waypoints/Egypt.cup .
wget http://download.xcsoar.org/waypoints/Estonia.cup .
wget http://download.xcsoar.org/waypoints/Finland.cup .
wget http://download.xcsoar.org/waypoints/France.cup .
wget http://download.xcsoar.org/waypoints/Germany.cup .
wget http://download.xcsoar.org/waypoints/Greece.cup .
wget http://download.xcsoar.org/waypoints/Hungary.cup .
wget http://download.xcsoar.org/waypoints/India.cup .
wget http://download.xcsoar.org/waypoints/Indonesia.cup .
wget http://download.xcsoar.org/waypoints/Iran.cup .
wget http://download.xcsoar.org/waypoints/Iraq.cup .
wget http://download.xcsoar.org/waypoints/Ireland.cup .
wget http://download.xcsoar.org/waypoints/Israel.cup .
wget http://download.xcsoar.org/waypoints/Italy.cup .
wget http://download.xcsoar.org/waypoints/Japan.cup .
wget http://download.xcsoar.org/waypoints/Latvia.cup .
wget http://download.xcsoar.org/waypoints/Libyan%20Arab%20Jamabiriya.cup .
wget http://download.xcsoar.org/waypoints/Liechtenstein.cup .
wget http://download.xcsoar.org/waypoints/Lithuania.cup .
wget http://download.xcsoar.org/waypoints/Luxembourg.cup .
wget http://download.xcsoar.org/waypoints/Macedonia.cup .
wget http://download.xcsoar.org/waypoints/Malawi.cup .
wget http://download.xcsoar.org/waypoints/Malaysia.cup .
wget http://download.xcsoar.org/waypoints/Malta.cup .
wget http://download.xcsoar.org/waypoints/Mexico.cup .
wget http://download.xcsoar.org/waypoints/Moldova.cup .
wget http://download.xcsoar.org/waypoints/Mongolia.cup .
wget http://download.xcsoar.org/waypoints/Morocco.cup .
wget http://download.xcsoar.org/waypoints/Mozambique.cup .
wget http://download.xcsoar.org/waypoints/Myanmar.cup .
wget http://download.xcsoar.org/waypoints/Namibia.cup .
wget http://download.xcsoar.org/waypoints/Netherlands.cup .
wget http://download.xcsoar.org/waypoints/New%20Zealand.cup .
wget http://download.xcsoar.org/waypoints/Niger.cup .
wget http://download.xcsoar.org/waypoints/Norway.cup .
wget http://download.xcsoar.org/waypoints/Oman.cup .
wget http://download.xcsoar.org/waypoints/Pakistan.cup .
wget http://download.xcsoar.org/waypoints/Poland.cup .
wget http://download.xcsoar.org/waypoints/Portugal.cup .
wget http://download.xcsoar.org/waypoints/Romania.cup .
wget http://download.xcsoar.org/waypoints/Russian%20Federation.cup .
wget http://download.xcsoar.org/waypoints/Serbia.cup .
wget http://download.xcsoar.org/waypoints/Slovakia.cup .
wget http://download.xcsoar.org/waypoints/Slovenia.cup .
wget http://download.xcsoar.org/waypoints/South%20Africa.cup .
wget http://download.xcsoar.org/waypoints/Spain.cup .
wget http://download.xcsoar.org/waypoints/Sri%20Lanka.cup .
wget http://download.xcsoar.org/waypoints/Sudan.cup .
wget http://download.xcsoar.org/waypoints/Sweden.cup .
wget http://download.xcsoar.org/waypoints/Switzerland.cup .
wget http://download.xcsoar.org/waypoints/Syrian%20Arab%20Republic.cup .
wget http://download.xcsoar.org/waypoints/Thailand.cup .
wget http://download.xcsoar.org/waypoints/Tunisia.cup .
wget http://download.xcsoar.org/waypoints/Turkey.cup .
wget http://download.xcsoar.org/waypoints/United%20Kingdom.cup .
wget http://download.xcsoar.org/waypoints/United%20States.cup .
wget http://download.xcsoar.org/waypoints/Uzbekistan.cup .
wget http://download.xcsoar.org/waypoints/Zambia.cup .
wget http://download.xcsoar.org/waypoints/Zimbabwe.cup .

# download airspace files
wget http://soaringweb.org/Airspace/AU/australia_class_all_15_11_12.txt -O ./Australia_Airspace.txt
wget https://www.austrocontrol.at/jart/prj3/austro_control/data/dokumente/aV5XF_AustriaAirspaceMainFileeffdate01052015-27052015V.1.00.txt -O ./Austria_Airspace.txt
wget http://soaringweb.org/Airspace/BE/BELLUX_WEEK_140501.txt -O ./BelgiumLux_Airspace_Week.txt
wget http://soaringweb.org/Airspace/BE/bellux_weekend_14_base_rev2.txt -O ./BelgiumLux_Airspace_Weekend.txt
wget http://soaringweb.org/Airspace/BR/BRA13A16.txt -O ./Brazil_Airspace.txt
wget http://pg.v5d.org/airspace/bg_airspace_latest.txt -O ./Bulgaria_Airspace.txt
wget http://soaringweb.org/Airspace/NA/canadian_airspace_254.air -O ./Canada_Airspace.txt
wget http://soaringweb.org/Airspace/HR/HRV-2012.txt -O ./Croatia_Airspace.txt
wget http://soaringweb.org/Airspace/CZ/Cz_all_2015_10_15.txt -O ./Czech_Airspace.txt
wget http://soaringweb.org/Airspace/DK/DK-AllinOne-20160408.txt -O ./Denmark_Airspace.txt
wget http://soaringweb.org/Airspace/FI/finland_airspace_20141103_openair.txt -O ./Finland_Airspace.txt
wget http://s289271336.onlinehome.fr/dossiers_ffvv/files/000000__AIRSPACE_latest.txt -O ./France-Airspace.txt
wget http://soaringweb.org/Airspace/DE/Germany_Week13_2016.txt -O ./Germany_Airspace.txt
wget http://www.daec.de/fileadmin/user_upload/files/2012/fachbereiche/luftraum/2016_April_Sprungzonen.txt -O ./Germany_ParachutingZones.txt
wget http://soaringweb.org/Airspace/GR/greece_03.txt -O ./Greece_Airspace.txt
wget http://soaringweb.org/Airspace/HU/Hungary_2012.txt -O ./Hungary_Airspace.txt
wget http://soaringweb.org/Airspace/IS/israel_2014_v01.txt -O ./Israel_Airspace.txt
wget http://soaringweb.org/Airspace/LV/lv_2014_05_04.txt -O ./Latvia_Airspace.txt
wget http://soaringweb.org/Airspace/LT/LT_2012.txt -O ./Lithuania_Airspace.txt
wget https://dl.dropboxusercontent.com/u/27739535/databases/EHv16_3.txt -O ./Netherlands_Airspace.txt
wget http://soaringweb.org/Airspace/NZ/NZ.txt -O ./New_Zealand_Airspace.txt
wget http://soaringweb.org/Airspace/PL/08_JAN_2015_Polska.txt -O ./Poland_Airspace.txt
wget http://soaringweb.org/Airspace/SK/LZBB140529.txt -O ./Slovakia_Airspace.txt
wget http://soaringweb.org/Airspace/SI/si_2016.04.txt -O ./Slovenia_Airspace.txt
wget http://soaringweb.org/Airspace/ES/SUASpain201509.txt -O ./Spain_Airspace.txt
wget http://soaringweb.org/Airspace/SE/Sverige-2016-WP-rev0.TXT -O ./Sweden_Airspace.txt
wget http://soaringweb.org/Airspace/CH/CH-Luftraum_2016_04_27.txt -O ./Switzerland_Airspace.txt
wget http://www.nvgc.org.uk/UK2016.txt -O ./UK_Airspace.txt
wget http://soaringweb.org/Airspace/NA/allusa.v16.03-31.2.txt -O ./USA_Airspace.txt

# download thermal hotspots
wget http://www.open-aip.org/public_export/hotspots/world_hot.cup -O ./OpenAIP-Hotspots.cup
wget http://glidinghotspots.eu/data/simple/0002/Thermal_Spaces_EU.txt -O ./Thermal_Spaces_EU.txt


# download flarmnet database
wget http://www.flarmnet.org/files/data.fln .

# download default-configuration
wget https://787a2ba0581dc73010e839636af3b9017e68e419.googledrive.com/host/0Byyp9TjGohLMNk9ncEdiQWNHUVk/custom.xci .
wget https://787a2ba0581dc73010e839636af3b9017e68e419.googledrive.com/host/0Byyp9TjGohLMNk9ncEdiQWNHUVk/default.prf

# download map files
wget http://download.xcsoar.org/maps/AFR_GARIEP_DAM_HighRes.xcm .
wget http://download.xcsoar.org/maps/AFR_NAMIBIA_CENTRAL_HighRes.xcm .
wget http://download.xcsoar.org/maps/ALPS_HighRes.xcm .
wget http://download.xcsoar.org/maps/ARG_ANDES_HighRes.xcm .
wget http://download.xcsoar.org/maps/ARG_CENTRO_HighRes.xcm .
wget http://download.xcsoar.org/maps/ARG_NORTE_HighRes.xcm .
wget http://download.xcsoar.org/maps/AUS_ADELAIDE_HighRes.xcm .
wget http://download.xcsoar.org/maps/AUS_BENALLA_HighRes.xcm .
wget http://download.xcsoar.org/maps/AUS_NORTHNSW_HighRes.xcm .
wget http://download.xcsoar.org/maps/AUS_NSW_VIC_HighRes.xcm .
wget http://download.xcsoar.org/maps/AUS_QLD_HighRes.xcm .
wget http://download.xcsoar.org/maps/AUS_WA_HighRes.xcm .
wget http://download.xcsoar.org/maps/BEN_WGER_HighRes.xcm .
wget http://download.xcsoar.org/maps/BRA_CENTRO_OESTE_HighRes.xcm .
wget http://download.xcsoar.org/maps/BRA_SOUTH_HighRes.xcm .
wget http://download.xcsoar.org/maps/BRA_SUDESTE_HighRes.xcm .
wget http://download.xcsoar.org/maps/BUL_HighRes.xcm .
wget http://download.xcsoar.org/maps/CAN_ONTARIO_HighRes.xcm .
wget http://download.xcsoar.org/maps/CAN_QUEBEC_S_HighRes.xcm .
wget http://download.xcsoar.org/maps/CAN_SE_BC_HighRes.xcm .
wget http://download.xcsoar.org/maps/CAN_SE_ONTARIO_HighRes.xcm .
wget http://download.xcsoar.org/maps/CAN_SW_ONTARIO_HighRes.xcm .
wget http://download.xcsoar.org/maps/CL_CHILE_CENTRO_HighRes.xcm .
wget http://download.xcsoar.org/maps/COLOMBIA_HighRes.xcm .
wget http://download.xcsoar.org/maps/CZ_SK_HighRes.xcm .
wget http://download.xcsoar.org/maps/ESP_BALEAR_HighRes.xcm .
wget http://download.xcsoar.org/maps/ESP_C_HighRes.xcm .
wget http://download.xcsoar.org/maps/ESP_N_HighRes.xcm .
wget http://download.xcsoar.org/maps/ESP_S_HighRes.xcm .
wget http://download.xcsoar.org/maps/FIN_HighRes.xcm .
wget http://download.xcsoar.org/maps/FRA_ALPS_HighRes.xcm .
wget http://download.xcsoar.org/maps/FRA_CORSE_HighRes.xcm .
wget http://download.xcsoar.org/maps/FRA_FULL_HighRes.xcm .
wget http://download.xcsoar.org/maps/FRA_SW_HighRes.xcm .
wget http://download.xcsoar.org/maps/GER_HighRes.xcm .
wget http://download.xcsoar.org/maps/HUN_HighRes.xcm .
wget http://download.xcsoar.org/maps/IRE_HighRes.xcm .
wget http://download.xcsoar.org/maps/ISR_ISRAEL_HighRes.xcm .
wget http://download.xcsoar.org/maps/ITA_APENN_HighRes.xcm .
wget http://download.xcsoar.org/maps/ITA_S_HighRes.xcm .
wget http://download.xcsoar.org/maps/ITA_SARD_HighRes.xcm .
wget http://download.xcsoar.org/maps/JP_HOK_HighRes.xcm .
wget http://download.xcsoar.org/maps/MEX_CENTER_HighRes.xcm .
wget http://download.xcsoar.org/maps/NOR_N_HighRes.xcm .
wget http://download.xcsoar.org/maps/NOR_S_HighRes.xcm .
wget http://download.xcsoar.org/maps/NZL_BOTHISLANDS_HighRes.xcm .
wget http://download.xcsoar.org/maps/NZL_SOUTHISLAND_HighRes.xcm .
wget http://download.xcsoar.org/maps/POL_HighRes.xcm .
wget http://download.xcsoar.org/maps/POR_HighRes.xcm .
wget http://download.xcsoar.org/maps/SWE_C_HighRes.xcm .
wget http://download.xcsoar.org/maps/SWE_N_HighRes.xcm .
wget http://download.xcsoar.org/maps/SWE_S_HighRes.xcm .
wget http://download.xcsoar.org/maps/UK_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_AZ_PLUS_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_CALIFORN_S_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_CA_TRUCKEE_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_COLORADO_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_FL_CENTRAL_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_HI_OAHU_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_HOBBS_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_ID_LOST_RIVER_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_ID_SOUTHWEST_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_ILLINOIS_NO_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_ILLINOIS_SO_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_INDIANA_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_MICHIGAN_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_NEWENGLAND_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_NEWMEXICO_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_NORTHEAST_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_OK_HINTON_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_OR_STATE_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_TEXAS_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_UTAH_R9N_HighRes.xcm .
wget http://download.xcsoar.org/maps/US_WA_STATE_HighRes.xcm .
cd
