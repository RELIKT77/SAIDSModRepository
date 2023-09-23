@BlockID "SG_Vulcan_SAMS_Block"
@Version 2
@Author Krynoc
@Weaponcore 0

#Valid subpart ID's of SG_Vulcan_SAMS_Block
#|  SGVulcanSAMSAzimuth
#|  |  SGVulcanSAMSElevation
#|  |  |  SGVulcanSAMSMissle1
#|  |  |  SGVulcanSAMSMissle2
#|  |  |  SGVulcanSAMSMIssleMuzzles

# Declarations
using Azimuth as Subpart("SGVulcanSAMSAzimuth")
using Elevation as Subpart("SGVulcanSAMSElevation") parent Azimuth

var isWorking = true

# Animations
func GunTurnOn() {
	if (isWorking == false) {
		API.StopDelays()
		Elevation.reset().Rotate([1, 0, 0], 15, 0, Instant).Rotate([1, 0, 0], -15, 100, Linear)
	}
	isWorking = true
}
func GunTurnOff() {
	if (isWorking == true) {
		API.StopDelays()
		Azimuth.MoveToOrigin(120, InOutSine)
		Elevation.MoveToOrigin(60, InOutSine).delay(60).Rotate([1, 0, 0], 15, 100, InOutSine).delay(100).reset().Rotate([1, 0, 0], 15, 0, Instant)
	}
	isWorking = false
}


# Events
Action Block() {
	Built() {
		isWorking = true
	}
	Working() {
		GunTurnOn()
	}
	NotWorking() {
		GunTurnOff()
	}
}






