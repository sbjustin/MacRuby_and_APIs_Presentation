#
#  AppDelegate.rb
#  ActiveLifeMacRubyApp
#
#  Created by Justin Nash on 4/5/12.
#  Copyright 2012 __SimplyBinary__. All rights reserved.
#
HOST = "localhost"
HOST_PORT = "3000"
class AppDelegate

    
    attr_accessor :window, :main_text, :event_name_field, :username, :userpass
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def windowWillClose(sender); exit; end
    
    def awakeFromNib; end
   
    def clear_main_text(sender)
        main_text.string= ""
        
    end
    
end

#curl -H "Content-Type: application/json" -u kirk@example.com:password123 -d '{"tweet":"War with Romulans @ 0700 in Neutral Zone", "activity_time":"2012-04-19T19:30:00Z", "activity_type":"Hangin with Kirk"}' http://localhost:3000/events

