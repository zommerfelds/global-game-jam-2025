extends Node2D

@onready var spectrum = AudioServer.get_bus_effect_instance(1, 1)
signal blow(power: float);

const MIN_HZ = 300
const MAX_HZ = 2000
const N_BUCKETS = 10
const BUCKET_WIDTH = (MAX_HZ-MIN_HZ)/N_BUCKETS
const MIN_BUCKET_DB = -110
var bucket_values = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bucket_values.resize(N_BUCKETS)

func _variance(a: Array) -> float:
	var sum_x = 0.0
	var sum_x2 = 0.0
	for el in a:
		sum_x += el
		sum_x2 += el**2
	return sum_x2/len(a) - (sum_x/len(a))**2

func _process(delta: float) -> void:
	var power = _blow_power()
	if power > 0.3:
		blow.emit(power)
	
func _blow_power() -> float:
	var hz_from = MIN_HZ
	var hz_to = MIN_HZ + BUCKET_WIDTH
	var total_mag = 0
	for i in range(N_BUCKETS):
		var mag = spectrum.get_magnitude_for_frequency_range(hz_from, hz_to)
		bucket_values[i] = clampf(linear_to_db(mag.x + mag.y) - MIN_BUCKET_DB, 0, 20)
		total_mag += bucket_values[i]
		hz_from += BUCKET_WIDTH
		hz_to += BUCKET_WIDTH
	if _variance(bucket_values) < 10:
		return total_mag / (N_BUCKETS*20)
	else:
		return 0
