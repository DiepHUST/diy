package diy.commands
{
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    
    import diy.business.ListDelegate;
    import diy.model.MainModelLocator;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.IResponder;

    public class GetListCommand implements ICommand, IResponder
    {
        private var modelLocator:MainModelLocator = MainModelLocator.getInstance();

        public function GetListCommand()
        {
        }

        public function execute(event:CairngormEvent):void
        {
            //因為要取用外部資料所以需要 Data delegate來輔助
            //Commond 都不用管 Delegate 如何取得資料
            var delegate:ListDelegate = new ListDelegate(this);
            delegate.getList();
        }

        public function result(event:Object):void
        {
            //會在 Delegate Layer 中將 result 處理成 ArrayCollection 型態
            modelLocator.list = event.result as ArrayCollection;
        }

        public function fault(event:Object):void
        {
            trace("Command: Get list fault");
        }
    }
}