extends Node3D

func play_confetti():
	$ConfettiParticles.emitting = true
	$PartyWhistle.play()
	$ConfettiPop.play()
	$Fanfare.play()
	await get_tree().create_timer(2.0).timeout
	$ConfettiParticles.emitting = false
	$PartyWhistle.stop()
	$ConfettiPop.stop()
	$Fanfare.stop()
