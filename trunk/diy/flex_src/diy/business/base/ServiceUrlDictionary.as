package diy.business.base
{
    public class ServiceUrlDictionary
    {
        [Bindable]
        public var sysConfigXmlUrl:String = "config/sysConfig.xml";
        
        [Bindable]
        public var listXmlUrl:String = "assets/test/list.xml";
        
        [Bindable]
        public var callHttpServiceFaultMessage:String = "Error connecting to " 
            + "the DIY Profile Server, please try again later.";
        
        private static var instance:ServiceUrlDictionary;
        private static var key:Boolean = false;
        
        public static function getInstance():ServiceUrlDictionary 
        {
            if (!instance)
            {
                key = true;
                instance = new ServiceUrlDictionary();
            }
            
            return instance;
        }
         
        public function ServiceUrlDictionary() 
        {
            if (instance || !key)
            {
                throw new Error("ServiceUrlDictionary singleton exception");
            }
            key = false;
            
            instance = this;
        }
    }
}