/**
 * Created with IntelliJ IDEA.
 * User: Łukasz@Rapidworks
 * Date: 05.05.14
 * Time: 13:07
 *
 */
package pl.mooska.events {
/**
 * @class pl.mooska.events.SignalDispatcher
 * @author Łukasz Błachowicz, rapidworks
 */
public class SignalDispatcher implements ISignalDispatcher{
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


	private var _signal:Signal = new Signal();
	//---------------------------------------------------------------
	// <------ PUBLIC METHODS ------>
	// METHODS VISIBLE
	//---------------------------------------------------------------
	public function add(type:String, callBack:Function):void {
		_signal.add(type, callBack);
	}

	public function remove(type:String, callBack:Function):void {
		_signal.remove(type, callBack);
	}

	public function clear(type:String):void {
		_signal.clear(type);
	}

	public function clearAll():void {
		_signal.clearAll();
	}

	public function dispatch(type:String, params:* = null):void {
		_signal.dispatch( type, params );
	}

	public function hasListener(type:String, callBack:Function):Boolean {
		return _signal.hasListener( type, callBack );
	}

	/** constructor **/
	public function SignalDispatcher() {
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
	protected function get signal():Signal
	{
	    return _signal;
	}

	//---------------------------------------------------------------
	// <------ PRIVATE METHODS ------>
	// METHODS VISIBLE ONLY INSIDE CLASS
	//---------------------------------------------------------------
}
}
