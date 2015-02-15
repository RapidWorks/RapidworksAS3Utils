/**
 * Created with IntelliJ IDEA.
 * User: Łukasz@Rapidworks
 * Date: 18.09.13
 * Time: 15:37
 *
 */
package pl.mooska.utils {
import flash.errors.IllegalOperationError;
import flash.utils.Dictionary;


/**
 * @class pl.merlin.utils.Pool
 * @author Łukasz Błachowicz, rapidworks
 */
public class Pool {
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

	private static var _objects:Dictionary = new Dictionary();
	//---------------------------------------------------------------
	// <------ PUBLIC METHODS ------>
	// METHODS VISIBLE
	//---------------------------------------------------------------

	public static function get(clss:Class, ... params:Array ):* {
		if (!_objects[clss]) _objects[clss] = [];
		if (_objects[clss].length == 0){

			if( params && params.length > 0 ){
//				if( !clss.getClassInstance ) throw new Error( "Class constructor uses parameters, is needs to implement static func getClassInstance" );
//				_objects[clss].push(clss.getClassInstance.apply(null, params));

				params.unshift( clss );
				_objects[clss].push( createWithParams.apply( null, params ) );
			}
			else{
				_objects[clss].push(new clss);
			}
		}

		return _objects[clss].shift();
	}

	/** Returns only one instance of selected class, every time (singleton) */
	public static function getSingle(clss:Class, ... params:Array):* {
		if (!_objects[clss]){
			if( params && params.length ){
				//_objects[clss] = new clss;
				//if( !clss.getClassInstance ) throw new Error( "Class constructor uses parameters, is needs to implement static func getClassInstance" );
				//_objects[clss].push(clss.getClassInstance.apply(null, params));
				params.unshift( clss );
				_objects[clss] = createWithParams.apply( null, params );
			} else{
				if( params && params.length ) throw new Error( "Cannot create item with params as its pooled" );
				_objects[clss] = new clss;
			}
		}
		if( _objects[clss] is Array ) throw new Error( "Created more then one instance: " +_objects[clss]+" class: " + clss+" params: " +params );
		return _objects[clss];
	}

	public static function isFromPool(item:*, clss:Class = null):Boolean {
		if (!clss) clss = item.constructor;
		return (_objects[clss].indexOf(item) != -1);
	}

	public static function retrieve(item:*, clss:Class = null):void {
		if (!clss) clss = item.constructor;

		if (_objects[clss].indexOf(item) != -1) throw new IllegalOperationError("POOL_DOUBLE_RETURN_ERROR");
		if(item is Array) item.length = 0;

		_objects[clss].push(item);
	}

	/** constructor **/
	public function Pool() {
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
	/* ugly, but simplifies creating constructor */
	protected static function createWithParams( clss:Class, ... params:Array ):* {
	    if( params ){
			if( params.length == 1 ){
				return new clss(params[0]);
			}else if( params.length == 2 ){
				return new clss(params[0], params[1]);
			}else if( params.length == 3 ){
				return new clss(params[0], params[1], params[2]);
			}else if( params.length == 4 ){
				return new clss(params[0], params[1], params[2], params[3]);
			}else if( params.length == 5 ){
				return new clss(params[0], params[1], params[2], params[3], params[4]);
			}
		}
	}

	//---------------------------------------------------------------
	// <------ PRIVATE METHODS ------>
	// METHODS VISIBLE ONLY INSIDE CLASS
	//---------------------------------------------------------------
}
}
