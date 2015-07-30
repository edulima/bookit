require 'spec_helper'


feature 'fff' do 

	background do
		visit config['url']
		puts "testsetset" + config['title']
		expect(page).to have_title config['']
	end	

	scenario 'Happy Path' do
		
		
		fill_in('MainContent_LoginUser_UserName', :with=> config['username'])
		fill_in('MainContent_LoginUser_Password', :with=> config['password'])


		page.find('#MainContent_LoginUser_LoginButton').click

		visit config['url_visa']

	

		page.find('#MainContent_LinkButtonNext').click

			# within :table, 'MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1' do

				
			# end

			available_dates = Array.new
			days_on_calendar = Array.new
			days_of_month = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
			#days_of_month = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,34]
			
			# page.all(:table, 'MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1').each do |el|
			  
				 unavailable = page.all('.aspNetDisabled')

				 newArray = []
				 inc = 0
				 for i in unavailable

				 		newArray.push(unavailable[inc].text)
			
				 		puts " Element value: " + newArray[inc] + " Element occurence: "  + newArray.count(inc).text

				 		inc = inc + 1

				 end

		

			

				
				newArray.delete_at(2) 
				

				 counter = 0
				 
				 for i in days_of_month
				 
				 	#test = unavailable_dates.include?(days_of_month[counter])
				 	test = days_of_month[counter]
				 	
				 	test2 = unavailable[counter].text
				
				 	# puts test
				 	# puts test2

				 	# puts unavailable_dates[counter].text
				 	# puts days_of_month[counter]
				
				 	if newArray.include?(test)
				 		puts "test"
				 	else
				 		puts "echo lo qui"
				 	end

				 	 counter = counter + 1	

				 end
				 
			# end
		
		
		sleep 10
	end

end