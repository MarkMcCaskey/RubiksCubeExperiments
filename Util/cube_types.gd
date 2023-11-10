class_name CubeTypes extends Node

enum FaceColor { White, Green, Red, Blue, Orange, Yellow }

enum EdgeName { AQ, BM, CI, DE, FL, GX, HR, JP, KU, NT, OV, SW }
enum CornerName { AER, BNQ, CJM, DIF, GLU, HSX, KPV, OTW }

static func edge_to_colors(en: EdgeName) -> Array[FaceColor]:
	match en:
		EdgeName.AQ: return [FaceColor.White, FaceColor.Blue]
		EdgeName.BM: return [FaceColor.White, FaceColor.Red]
		EdgeName.CI: return [FaceColor.White, FaceColor.Green]
		EdgeName.DE: return [FaceColor.White, FaceColor.Orange]
		EdgeName.FL: return [FaceColor.Green, FaceColor.Orange]
		EdgeName.GX: return [FaceColor.Yellow, FaceColor.Orange]
		EdgeName.HR: return [FaceColor.Blue, FaceColor.Orange]
		EdgeName.JP: return [FaceColor.Green, FaceColor.Red]
		EdgeName.KU: return [FaceColor.Yellow, FaceColor.Green]
		EdgeName.NT: return [FaceColor.Blue, FaceColor.Red]
		EdgeName.OV: return [FaceColor.Yellow, FaceColor.Red]
		EdgeName.SW: return [FaceColor.Yellow, FaceColor.Blue]
		_:
			assert(false, "impossible case")
			return []

# All colors are output as if looking at it with "Front face on", not based on the name
static func corner_to_colors(cn: CornerName) -> Array[FaceColor]:
	match cn:
		CornerName.AER: return [FaceColor.White, FaceColor.Blue, FaceColor.Orange]
		CornerName.BNQ: return [FaceColor.White, FaceColor.Red, FaceColor.Blue]
		CornerName.CJM: return [FaceColor.White, FaceColor.Green, FaceColor.Red]
		CornerName.DIF: return [FaceColor.White, FaceColor.Orange, FaceColor.Green]
		CornerName.GLU: return [FaceColor.Yellow, FaceColor.Green, FaceColor.Orange]
		CornerName.HSX: return [FaceColor.Yellow, FaceColor.Orange, FaceColor.Blue]
		CornerName.KPV: return [FaceColor.Yellow, FaceColor.Red, FaceColor.Green]
		CornerName.OTW: return [FaceColor.Yellow, FaceColor.Blue, FaceColor.Red]
		_:
			assert(false, "impossible case")
			return []

static func face_color_to_color(fc: FaceColor) -> Color:
	match fc:
		FaceColor.White: return Color.WHITE
		FaceColor.Green: return Color.GREEN
		FaceColor.Red: return Color.RED
		FaceColor.Blue: return Color.BLUE
		FaceColor.Orange: return Color.ORANGE
		FaceColor.Yellow: return Color.YELLOW
		_:
			assert(false, "impossible case")
			return Color.PINK
