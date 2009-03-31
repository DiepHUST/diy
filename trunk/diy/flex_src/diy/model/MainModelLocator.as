package diy.model
{
    import com.adobe.cairngorm.model.ModelLocator;
    
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class MainModelLocator implements ModelLocator
    {
        private static var instance:MainModelLocator = null;
        private static var allowInstantiation:Boolean = false;
        
        public var list:ArrayCollection = new ArrayCollection;
        
        public function MainModelLocator()
        {

            if (!allowInstantiation)
            {
                throw new Error("Error: Instantiation failed: Use " 
                + "MainModelLocatorMainModelLocator.getInstance() "
                + "instead of new MainModelLocator().");
            }
        }

        public static function getInstance():MainModelLocator
        {

            if (instance == null)
            {
                allowInstantiation = true;
                instance = new MainModelLocator();
                allowInstantiation = false;
            }
            return instance;
        }
    }
}