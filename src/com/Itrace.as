/**
 * 
 * Itrace：在舞台中添加一个信息显示板，用于调试时输出信息。
 * 
 * 程序发布，可移除该类的引用，减少体积
 * 
 * */
package com
{
	import flash.events.MouseEvent;
	
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.core.FlexGlobals;
	
	import spark.components.TextArea;

	public class Itrace
	{
		private var iPanel:Panel;
		private var iText:TextArea;
		private var iButton:Button;
		
		/**
		 * 
		 * Itrace: 舞台添加调试板，包含Panel(容器)，TextArea(输出信息)，Button（清除按钮）
		 * 
		 * @return void
		 * 
		 * */
		public function Itrace():void
		{
			//舞台添加一个可拖动的容器
			iPanel = new Panel();
			iPanel.title = "trace";
			iPanel.width = 400;
			iPanel.height = 400;
			iPanel.x = 100;
			iPanel.y = 100;
			iPanel.alpha = 0.8;
			iPanel.layout = "absolute";
			iPanel.addEventListener(MouseEvent.MOUSE_DOWN, function():void{ iPanel.startDrag(); });
			iPanel.addEventListener(MouseEvent.MOUSE_UP,function():void{ iPanel.stopDrag(); });			
			
			//容易中添加一个文本区域，用于显示信息
			iText = new TextArea();
			iText.width = 375;
			iText.height = 320;
			iText.x = 10;
			iText.y = 10;
			iPanel.addElement(iText);
			
			//添加一个清空按钮
			iButton = new Button;			
			iButton.label = "clear";
			iButton.addEventListener(MouseEvent.CLICK, function():void{ iText.text = ""; });
			iButton.x = 10;
			iButton.y = 340;
			iPanel.addElement(iButton);
			
			FlexGlobals.topLevelApplication.addElement(iPanel);
		}
		
		/**
		 * 
		 * windowsStatus: 显示隐藏调试窗口
		 * 
		 * @param _boolean:Boolean true false
		 * 
		 * @return void
		 * 
		 * */
		public function windowsStatus(_boolean:Boolean):void
		{
			iPanel.visible = _boolean;
		}
		
		/**
		 * 
		 * traceString: 输出字符串信息
		 * 
		 * @param _value:String 需要输出的字符串
		 * 
		 * @return void
		 * 
		 * */
		public function traceString(_value:String):void
		{
			_output(_value);
		
		}
		
		/**
		 * 
		 * traceObject：打印object的结构和信息
		 * 
		 * @param obj:* 所有类型，例如：object,array,json.
		 * 
		 * @retrun *
		 * 
		 * */
		public function traceObject(obj:*,level:int=0,output:String=""):*
		{
			var tabs:String = "";
			for(var i:int=0; i<=level; i++, tabs+="\t"){
				for(var child:* in obj){
					output += tabs +"["+ child +"] => "+obj[child];
					var childOutput:String=traceObject(obj[child], level+1);
					if(childOutput!=''){
						output+=' {\n'+childOutput+tabs +'}';
					}
					output += "\n";
				}
				
				_output(output);
			}
		}
		
		/**
		 * 
		 * _output: 容器中输出信息
		 * 
		 * @param _value:String textarea只输出字符串
		 * 
		 * @return void
		 * 
		 * */		
		private function _output(_value:String):void
		{
			iText.text += "\n" + _value;	
			//自动滚到最下面去
			iText.validateNow();
			iText.scroller.verticalScrollBar.value = iText.scroller.verticalScrollBar.maximum;
		}
	}
}