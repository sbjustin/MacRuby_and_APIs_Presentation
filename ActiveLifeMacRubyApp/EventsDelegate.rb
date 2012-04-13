#
#  EventsDelegate.rb
#  ActiveLifeMacRubyApp
#
#  Created by Justin Nash on 4/5/12.
#  Copyright 2012 __MyCompanyName__. All rights reserved.
#

class EventsDelegate
    require 'net/http'
    require 'json'
    require 'date'
    
    attr_accessor :main_text
    attr_accessor :new_event_street, :new_event_city, :new_event_state, :new_event_country, :new_event_zip, :new_event_activity_type, :new_event_time, :events_table, :username, :userpass
    
    
    def create_event(sender)
        uri = URI('http://'+HOST+':'+HOST_PORT+'/events')
        
        req = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
        req.basic_auth 'kirk@example.com', 'password123'
        req.body = {
            "event" => {
                "street" => new_event_street.stringValue,
                "city" => new_event_city.stringValue,
                "state" => new_event_state.stringValue,
                "country" => new_event_country.stringValue,
                "zip" => new_event_zip.stringValue,
                "activity_time" => new_event_time.stringValue,
                "activity_type" => new_event_activity_type.stringValue,
                "tweet" => new_event_activity_type.stringValue + " @ " + new_event_time.stringValue + " on the Enterprise"
            }
        }.to_json
        res = Net::HTTP.new(uri.host, uri.port).start {|http| http.request(req) }
        main_text.string = res.header.to_s + res.body
                
    end
    
    def get_events_with_ruby(sender)        
        uri = URI('http://'+HOST+':'+HOST_PORT+'/events')
        
        req = Net::HTTP::Get.new(uri.request_uri)
        req.basic_auth username.stringValue, userpass.stringValue#'kirk@example.com', 'password123'
        req.set_content_type("application/json")
        res = Net::HTTP.start(uri.host, uri.port) {|http|
            http.request(req)
        }
        
        @event_json = JSON.parse(res.body)
        main_text.string = res.header.to_s + res.body
        events_table.dataSource = self
        events_table.reloadData
    end
    
    #Events Table
    
    #@data = []
    #@symlinkTableView.dataSource = self
    
    def numberOfRowsInTableView(aTableView)
        @event_json.size
    end
    
    def tableView(aTableView, objectValueForTableColumn: acolumn, row: rowIndex)

        rowData = @event_json[rowIndex]
        case acolumn.identifier
            when 'event_type'
            rowData['activity_type']
            when 'event_time'
            d=DateTime.parse(rowData['activity_time']).to_time.to_s
            when 'address'
            rowData['street']
            when 'city'
            rowData['city']
            when 'state'
            rowData['state']
            when 'country'
            rowData['country']
            when 'zip'
            rowData['zip']
            when 'id'
            rowData['id']
        end
        
    end
    
    def clickedRow(sender)
        @table_selected_row = sender.selectedRow
    end
    
    def delete_event(sender)    
        uri = URI('http://'+HOST+':'+HOST_PORT+'/events/' + @event_json[@table_selected_row]['id'])
        
        req = Net::HTTP::Delete.new(uri.request_uri,initheader = {'Depth' => 'Infinity'})
        req.basic_auth 'kirk@example.com', 'password123'
        res = Net::HTTP.start(uri.host, uri.port) {|http|
            http.request(req)
        }
        main_text.string = res.header.to_s + res.body

    end
    
    

end