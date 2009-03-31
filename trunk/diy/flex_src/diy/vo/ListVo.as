package diy.vo
{
    import com.adobe.cairngorm.vo.IValueObject;
    
    public class ListVo implements IValueObject
    {
        private var _label:String;
        private var _data:String;
        
        public function ListVo(labelValue:String, dataValue:String)
        {
            this._data = dataValue;
            this._label = labelValue;
        }
        
        public function get label():String
        {
            return _label;
        }
        
        public function set label(value:String):void
        {
            this._label = value;
        }
        
        public function get data():String
        {
            return _data;
        }
        
        public function set data(value:String):void
        {
            this._data = value;
        }
        
    }
}
