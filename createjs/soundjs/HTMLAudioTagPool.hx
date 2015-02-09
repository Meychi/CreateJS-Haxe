package createjs.soundjs;

/**
* The TagPool is an object pool for HTMLAudio tag instances. In Chrome, we have to pre-create the number of HTML
*	audio tag instances that we are going to play before we load the data, otherwise the audio stalls.
*	(Note: This seems to be a bug in Chrome)
*/
@:native("createjs.HTMLAudioTagPool")
extern class HTMLAudioTagPool
{
}
