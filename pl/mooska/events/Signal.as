/**
 * Created with IntelliJ IDEA.
 * User: Łukasz@Rapidworks
 * Date: 16.09.13
 * Time: 22:50
 *
 */
package pl.mooska.events {
import pl.mooska.utils.Pool;

/**
 * @author Łukasz Błachowicz, rapidworks
 */
public class Signal {
	//---------------------------------------------------------------
	// <------ PUBLIC CONSTS ------>
	//---------------------------------------------------------------
	//---------------------------------------------------------------
	// <------ PUBLIC VARS ------>
	//---------------------------------------------------------------


	//---------------------------------------------------------------
	// <------ INTERNAL CONSTS ------>
	//---------------------------------------------------------------
	//---------------------------------------------------------------
	// <------ INTERNAL VARS ------>
	//---------------------------------------------------------------


	//---------------------------------------------------------------
	// <------ PROTECTED CONSTS ------>
	//---------------------------------------------------------------
	//---------------------------------------------------------------
	// <------ PROTECTED VARS ------>
	//---------------------------------------------------------------


	//---------------------------------------------------------------
	// <------ PRIVATE CONSTS ------>
	//---------------------------------------------------------------
	//---------------------------------------------------------------
	// <------ PRIVATE VARS ------>
	//---------------------------------------------------------------

	private var _listeners:Object = {};
	public var _id:int = Math.random() * 999999999;
	//---------------------------------------------------------------
	// <------ PUBLIC METHODS ------>
	// METHODS VISIBLE
	//---------------------------------------------------------------

	public function add(type:String, callBack:Function):void {
		if( !_listeners[type] ) _listeners[type] = [];


		_listeners[type].push( callBack );
	}

	public function remove( type:String, callBack:Function ):void {
		if( !_listeners[type] ) return;

		_listeners[type].splice( _listeners[type].indexOf( callBack ), 1);
	}

	public function hasListener(type:String, callBack:Function):Boolean {
		if(!_listeners[type]) return false;
		return (_listeners[type].indexOf( callBack ) != -1 );
	}

	public function clear( type:String ):void {
		if(_listeners[type]) _listeners[type].length = 0;
		delete _listeners[type];
	}

	public function clearAll():void {
		for each( var arr:Array in _listeners ){
			arr.length = 0;
		}

		_listeners = {};
	}

	/* @params Can be both Array, or single object (itll be converted to array with one element) */
	public function dispatch( type:String, params:* = null ):void {
		if( !_listeners[type] ) return;

		var parameters:Array;

		if( params is Array ) parameters = params;
		else {
			parameters = Pool.get(Array);
			if( params ) parameters.push( params );
		}

		/* callback are not sorted in any way */
		for each( var callBack:Function in _listeners[type] ){
			//if( callBack.length < parameters.length ) throw new Error( "Incorrect number of arguments on signal: " +type+" sent: " + parameters.length +" callback: " + callBack.length );
			callBack.apply( null, parameters );
		}

		if( Pool.isFromPool( parameters ) ) Pool.retrieve( parameters );
	}

	/** constructor **/
	public function Signal() {
		super();
	}

	//---------------------------------------------------------------
	// <------ INTERNAL METHODS ------>
	// METHODS VISIBLE ONLY INSIDE PACKAGE
	//---------------------------------------------------------------


	//---------------------------------------------------------------
	// <------ PROTECTED METHODS ------>
	// METHODS VISIBLE ONLY FOR INHERITORS
	//---------------------------------------------------------------


	//---------------------------------------------------------------
	// <------ PRIVATE METHODS ------>
	// METHODS VISIBLE ONLY INSIDE CLASS
	//---------------------------------------------------------------
}
}
