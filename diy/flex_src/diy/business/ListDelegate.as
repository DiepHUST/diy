package diy.business
{
    import com.adobe.cairngorm.business.ServiceLocator;
    
    import diy.vo.ListVo;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.IResponder;
    import mx.rpc.Responder;
    import mx.rpc.events.ResultEvent;

    public class ListDelegate
    {
        private var responder:IResponder;
        private var service:Object;

        public function ListDelegate(responder:IResponder)
        {
            this.responder = responder;
//            this.service = ServiceLocator.getInstance()
//                .getHTTPService("GetListService" );
            this.service = ServiceLocator.getInstance()
                .getRemoteObject("GetListService");
        }

        public function getList():void
        {
            var call:Object = service.getString();

            var responder:Responder = new Responder(onResult, onFault);
            call.addResponder(responder);
        }

        private function onResult(event:ResultEvent):void
        {
            var xml:XML = XML(event.result);
            var list:ArrayCollection = new ArrayCollection;

            for each(var subxml:XML in xml.list)
            {
                list.addItem(new ListVo(subxml.@name, subxml.@data));
            }
            //處理完後送回給 ListCommand
            //如果取用 list.xml 的方法轉成 remoting or webService 的話，也只是需要換掉這個 Class
            responder.result(new ResultEvent(ResultEvent.RESULT, false, true, list));
        }

        private function onFault(event:Object):void
        {
            trace(" load list.xml fault~~~");
        }
    }
}