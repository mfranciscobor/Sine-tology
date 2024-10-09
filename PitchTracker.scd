//
//  Pitch tracker.scd
//  Created by Andrea on 21/11/16.
//


//Pitch tracker example:
//this is a possible way to track the pitch of an incoming signal and map It to the frequency control of an other  oscillator.
//Pitch work in time domain so is not needed the FFT.

//calculate freq from input signal and use it to control a SinOsc

//Pitch returns two values, a freq which is the pitch estimate and hasFreq, which tells whether a pitch was found. Some vowels are still problematic and can contains enough overtone energy to confuse the algorithm.

//execute the code below to start the example
(
{
	//stereo input from sound card channel 0 and 1
	Ndef(\input).stop;
	Ndef(\input).fadeTime = 0;
	Ndef(\input,{
		SoundIn.ar([0,1]);
	}).mold(2).quant_(0);

	//stereo pitch tracker
	Ndef(\pitchTracker).stop;
	Ndef(\pitchTracker).fadeTime = 0;
	Ndef(\pitchTracker,{
		    var in, amp, freq, hasFreq, out;
		    in = Mix.new(\in.ar([0,1]));
		    amp = Amplitude.kr(in, 0.05, 0.05);
		   //Pitch return freq  & hasfreq
		    # freq, hasFreq = Pitch.kr(in, ampThreshold: 0.02,peakThreshold:0.5,median: 7);
			freq.poll;//print the frequency value fro debub pourpuse
		   // hasFreq.poll;//print the frequency value fro debub pourpuse
			Out.kr(0,freq);
	}).mold(2).quant_(0);

	//stereo output
	Ndef(\out).stop;
	Ndef(\out).fadeTime = 0;
	Ndef(\out,{
			SinOsc.ar(\in.kr(0));
	}).mold(2).quant_(0);

	0.2.wait;//server wait time

	//audio routing
	Ndef(\out) <<> Ndef(\pitchTracker) <<> Ndef(\input);

	//frequency scope
	w = Window("Pitch tracker", Rect(0, 0, 511, 300)); // width should be 511
	f = FreqScopeView(w, w.view.bounds);
	f.freqMode_(1); // change to log scale so we can see them
	f.active_(true); // turn it on the first time;
	w.onClose_({ f.kill }); // you must have this
	w.front;

	//play
	Ndef(\out).play;

}.fork(AppClock);

)