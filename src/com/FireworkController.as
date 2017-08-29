package com
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class FireworkController extends Sprite
	{
		private var _typeClass:Class;
		private var _stars:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var _maxRadius:Number = 250;
		private var _radius:Number = 20;
		private var _starNum:int = 100;
		private var _dis:int = 500;
		private var _angleY:Number = 0;
		
		public function FireworkController(typeClass:Class , maxRadius:Number)
		{
			super();
			_typeClass = typeClass;
			_maxRadius = maxRadius;
			createStars(_starNum);
		}
		
		public function play():void {
			_radius = 50;
			_dis = 500;
			_angleY = 0;
			for(var i:int= 0 ; i<_stars.length ; i++){
				_stars[i].gotoAndPlay(1);
				this.addChild(_stars[i]);
			}
			this.addEventListener(Event.ENTER_FRAME , onSetFirestarPos);
			TweenMax.delayedCall(3.5,stop);
		}
		
		public function stop():void {
			
			for(var i:int= 0 ; i<_stars.length ; i++){
				if(_stars[i].parent)this.removeChild(_stars[i]);
			}
			this.removeEventListener(Event.ENTER_FRAME , onSetFirestarPos);
		}
		
		protected function onSetFirestarPos(event:Event):void
		{
			// TODO Auto-generated method stub
			_radius += _radius*(_maxRadius-_radius)*0.001;
			var vets:Vector.<Vector3D> = calPos(_radius);
			if(_typeClass == FireStar){
				_angleY+=0.01;
			}else{
				_angleY-=0.01;
			}
			
			projection(vets , _dis , _angleY);
		}
		
		private function projection(vets:Vector.<Vector3D>, dis:int , angleY:Number):void
		{
			// TODO Auto Generated method stub
			for(var i:int= 0 ; i<vets.length ; i++){
				var star:DisplayObject = _stars[i];
				var c1:Vector3D = vets[i];
				var c2:Vector3D = rotateX(c1.x , c1.y , c1.z , 25);
				var c3:Vector3D = rotateY(c2.x , c2.y , c2.z , angleY);
				var c4:Vector3D = rotateZ(c3.x , c3.y , c3.z , 0);
				var h:Number = 1 - c4.z / dis;
				
				
				star.x = c4.x / h + Firework._Stage.stageWidth*0.5;
				star.y = c4.y / h + Firework._Stage.stageHeight*0.5;
				var scale:Number = Math.min(Math.max((_radius+0.5*c1.z)/_radius , 0.5) , 1) * 0.8;
				star.alpha = star.scaleY = star.scaleX =   scale;
			}
		}
		
		protected function createStars(num:int):void {
			for(var i:int=0 ; i<num ; i++){
				if(_typeClass == FireStar){
					var star:FireStar = new FireStar();
					_stars.push(star);
				}else{
					var star1:FireStar1 = new FireStar1();
					_stars.push(star1);
				}
				
				
			}
		}
		
		protected function calPos(radius:Number):Vector.<Vector3D> {
			var vets:Vector.<Vector3D> = new Vector.<Vector3D>();
			var col:int = 0;
			var row:int = 0;
			for(var i:int=0 ; i<_stars.length ; i++){
				col = i;
				if(i>0 && col%10==0)row++;
				var a:int = 36 * (col%10);
				var b:int = 36 * row;
//				trace("a : " + a , "b : " + b);
				vets.push(new Vector3D( radius * Math.sin(a) * Math.cos(b) , 
										radius * Math.sin(a) * Math.sin(b) , 
										radius * Math.cos(a)));
			}
			return vets;
		}
		
		protected function rotateZ(x, y, z, a):Vector3D {//繞Z軸旋轉
			return new Vector3D(x * Math.cos(a) - y * Math.sin(a),
								x * Math.sin(a) + y * Math.cos(a),
								z);
		}
		
		protected function rotateY(x, y, z, a):Vector3D {//繞Z軸旋轉
			return new Vector3D(x * Math.cos(a) + z * Math.sin(a),
								y,
								z * Math.cos(a) - x * Math.sin(a));
		}
		
		protected function rotateX(x, y, z, a):Vector3D {//繞Z軸旋轉
			return new Vector3D(x,
								y * Math.cos(a) - z * Math.sin(a),
								y * Math.sin(a) + z * Math.cos(a));
		}
	}
}