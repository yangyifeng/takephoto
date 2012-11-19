/**
 * 
 * UrlHelper: 网络辅助 
 * 
 * 包括：
 * 从url获取返回值(json)
 * 从url获取返回图片的bitmapdata
 * 获取地址栏中的某个参数的值
 * 
 * */
package com
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	//import mx.controls.Alert;
	
	public class UrlHelper
	{		
		/**
		 * 
		 * urlGet: 从url获取返回值
		 * 
		 * @param url:String 完整的url,例如：http://www.xxx.com/
		 * @param callback:Function 成功回调函数，类型是event:Event，返回值为event.currentTarget.data
		 * 
		 * 成功回调函数 需要加入“清除加载提示”，等设计出来再搞
		 * 
		 * 该函数中暂时屏蔽了错误回调，错误的显示方式，等设计出来后再搞
		 * 
		 * @return void
		 * 
		 * */
		public static function urlGet(url:String, callback:Function):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(Event.COMPLETE, callback);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				//Alert.show(event.target.data, "错误返回");
			});
		}
		
		/**
		 * 
		 * toNavigate: 新建浏览器窗口打开URL
		 * 
		 * @param url:String 完整的url,例如：http://www.xxx.com/
		 * 
		 * 
		 * @return void
		 * 
		 * */
		public static function navigateToUrl(url:String):void
		{
			var request:URLRequest = new URLRequest(url);
			
			navigateToURL(request,"_blank");
		}
		
		/**
		 * 
		 * getImage: 从url获取返回的静态图片，非动态gif
		 * 
		 * @param url:String 一个图片的地址，例如:http://www.xxx.com/aaa.jpg
		 * @param callback:Function 成功回调函数，返回值是bitmapData
		 * 
		 * 成功回调的函数，只有一个参数（bitmapData），提供给Image组件使用
		 * 
		 * 返回失败的解决：
		 * 假如返回失败，会从defaultImage中显示一个默认的图片
		 * 请确保defaultImage可以正常调用。
		 * 
		 * 如果需要其他解决方式，再继续补充.
		 * 
		 * */
		public static function getImage(url:String, callback:Function):void
		{
			var urlLoader:Loader = new Loader();
			urlLoader.load(new URLRequest(url));
			urlLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void{
				var bitmapdata:BitmapData = event.target.content.bitmapData;
				callback(bitmapdata);
			});
			urlLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				//Alert.show("错误返回");
				var defaultImage:String = "http://www.baidu.com/img/baidu_sylogo1.gif";
				getImage(defaultImage, callback);
			});
		}
		
		/**
		 * 
		 * param：获取地址栏中的某个参数的值，例如：从http://www.xxx.com/xxx.html?aaa=bbb&ccc=ddd中获取ccc的值ddd
		 * 
		 * @param _key:String 地址栏中的参数
		 * 
		 * @return String 返回该参数的值
		 * 
		 * */
		public static function param(_key:String):String
		{
			var returnValue:String = "";
			var currenUri:String = ExternalInterface.call("window.location.search.substring",1); 
			
			if(currenUri != "" && currenUri.indexOf(_key) != -1)
			{
				var split_currenUri:Array = currenUri.split("&");
				for(var i:int=0;i<split_currenUri.length;i++)
				{
					if(split_currenUri[i].indexOf(_key) != -1)
					{
						var split_value:Array = split_currenUri[i].split("=");
						returnValue = split_value[1];
						break;
					}
				}
			}
			
			return returnValue;
		}
	}
}