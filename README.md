SZU Sound Visualizer
===
[Live Demo](http://demo.filipszu.pl/Sound_Visualizer/)
---
Sound Visualizer is an ActionScript 3.0 application I made during my experiments with the computeSpectrum() method of the SoundMixer Class. It's a dynamic animation based on the music  that's playing in the background.I had a lot of fun with the computeSpectrum method I find it very inspiring to be able to make Music "appear" in a visual form. 

The computeSpectrum() method let's you get a snapshot of the current sound wave and store it in a ByteArray. This way you get a vector of 512 numbers representing the sound wave. Keep in mind that the first 256 values are the left channel and the other 256 values the right channel. The values range from -1 to 1 representing the amplitude. I've used a single BitmapData to draw out the sound wave. I've also added a simple GUI to change the music, the color of the bars and the amount of bars that appear.

***
<pre>
  ___  _  _  _        ___  ____ _   _ 
 | __|(_)| |(_) _ __ / __||_  /| | | |
 | _| | || || || '_ \\__ \ / / | |_| |
 |_|  |_||_||_|| .__/|___//___| \___/ 
               |_|    Interactive Developer
</pre>
URL: [filipszu.pl](http://www.filipszu.pl/)

Follow me: [@filipszu](https://twitter.com/filipszu)
