package diy.control
{
    import com.adobe.cairngorm.control.FrontController;
    
    import diy.commands.GetListCommand;

    public class Controller extends FrontController
    {
        public function Controller()
        {
            super();
            addCommand( "getList", GetListCommand);
        }
        
    }
}