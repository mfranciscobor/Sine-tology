//Basic code to change the colors of the Stethoscope in SuperCollider.

Server.default.options.numInputBusChannels = 8 // Set number of channels
Server.default.options.numOutputBusChannels = 8 // Set number of channels

s.scope.view.view.children[4].background_(Color.grey) // Set main window background color
s.scope.view.view.children[4].waveColors_({Color.blue} ! s.scope.numChannels) // Set waveform color

s.scope.view.view.children[0].background_(Color.grey) // Set 1st window background color - Audio/Control
s.scope.view.view.children[1].background_(Color.grey) // Set 2nd window background color - Number box
s.scope.view.view.children[2].background_(Color.grey) // Set 3rd window background color - Number of channels
s.scope.view.view.children[3].background_(Color.grey) // Set 4th window background color - Tracks/overlay/XY
s.scope.view.view.children[5].background_(Color.grey) // Set 5th window background color - Right slider
s.scope.view.view.children[6].background_(Color.grey) // Set 6th window background color - Bottom slider

s.scope.yZoom =  16 // Move the right slider
s.scope.xZoom = 0.4 // Move the bottom slider