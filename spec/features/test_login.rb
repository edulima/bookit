require 'spec_helper'
require 'pp'



feature 'fff' do 

	background do
		visit config['url']
		expect(page).to have_title config['']
	end	

	scenario 'Happy Path' do
		
		fill_in('MainContent_LoginUser_UserName', :with=> config['username'])
		fill_in('MainContent_LoginUser_Password', :with=> config['password'])


		page.find('#MainContent_LoginUser_LoginButton').click

		visit config['url_visa']

			page.find('#MainContent_LinkButtonNext').click

			times_array = Array.new(42) { Array.new(5,0) }

			days_of_month_array = get_days_of_month()
			
			#start current month
	    booked_days_array = get_booked_days(page.all('.aspNetDisabled'))
			get_available_days_and_times(days_of_month_array, booked_days_array, getCurrentMonth(), times_array)

			sleep 3
			
			click_next_month_link()

			#start next month
			get_month_array = setSeptemberCalendar()
			for i in get_month_array
				number =  get_booked_days(page.all(:xpath, "//a[contains(@title, \"#{get_month_array[i.to_i]} September\")]"))
				puts number.inspect
			end

			# booked_days_array = get_booked_days(page.all('.aspNetDisabled'))

			# get_available_days_and_times(days_of_month_array, booked_days_array, getNextMonth(), times_array)

			sleep 3
				 
	end

end

		def get_booked_days(array)

				 newArray = []
				 inc = 0
				 for i in array
						 	newArray.push(array[inc].text)	 
						 	inc +=1
				 end

				return newArray

		end	


		def setAugustCalendar()

			 calendar = Array.new
			 calendar = ["27", "28", "29", "30", "31","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","1","2","3","4","5","6"]

			 return calendar

		end

		def setSeptemberCalendar()

			 calendar = Array.new
			 calendar = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]

			 return calendar

		end


		# def find_available_days(str, dayOfMonth, month)

		# 		if str == 0

		# 			return dayOfMonth

		# 		elsif str == 1

		# 					if month == "August"
								
		# 						countDaysOnMontg = setAugustCalendar()
		# 						days = countDaysOnMontg.count(dayOfMonth)
		# 							puts "returning days: #{days}"
		# 							if days == 2
		# 				  				return dayOfMonth
		# 							end	

		# 					elsif month == "September"

		# 						countDaysOnMontg = setSeptemberCalendar()
		# 						days = countDaysOnMontg.count(dayOfMonth)

		# 							if days == 2
		# 				  				return dayOfMonth
		# 							end	
								
		# 					end
		# 		end

		# end

			def find_available_days_master(number_of_booked_days, dayOfMonth, month)

				if number_of_booked_days == 0

					return dayOfMonth

				elsif number_of_booked_days == 1

							if month == "August"
								
								countDaysOnMontg = setAugustCalendar()
								days = countDaysOnMontg.count(dayOfMonth)
									if days == 2
										puts "returning day of month: #{dayOfMonth}"
						  				return dayOfMonth
									end	

							elsif month == "September"

								countDaysOnMontg = setSeptemberCalendar()
								days = countDaysOnMontg.count(dayOfMonth)

									if days == 2
						  				return dayOfMonth
									end	
								
							end
				end

		end

		def click_next_month_link()

			within("table#MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1") { 
				find(:xpath, "//a[contains(@title, \"next\")]").click }

		end

		def click_on_available_day_to_display_time(day)

			within("table#MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1") { 
				find(:xpath, "//a[contains(@title, \"#{day}\")]").click }

		end

		def test(day)

			within("table#MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1") { 
				find(:xpath, "//a[contains(@title, \"#{day}\")]").text }

		end

		def getAvailableTime()
		 		timesAvailable = page.all('.CalendarSlot_DataList_Item')
		 		return timesAvailable
		end

		def findCurrentMonth()
				page.all(:table, 'MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1').each do |el| 
					ar = el.text
					return ar.scan("August")
				end

		end

		def getCurrentMonth()
			return Time.now.strftime("%B")
		end

		def getNextMonth()
			return Date.today.next_month.strftime("%B")
		end


		def get_available_days_and_times(days_of_month_array, booked_days_array, month, times_array)
			 puts "mes #{month} #{booked_days_array.inspect}"
			 available_times_array = Array.new
			 inc = 0
			 
						 for i in days_of_month_array

						 	  available_times_array.clear
						
								number_of_booked_days = booked_days_array.count(days_of_month_array[inc])
								
								# temp_day = find_available_days(number_of_booked_days, days_of_month_array[inc], calendar)
								temp_day = find_available_days_master(number_of_booked_days, days_of_month_array[inc], month)
								
								if temp_day != nil
							
									click_on_available_day_to_display_time(temp_day)

									tempArray = getAvailableTime()

									t = 0
									for i in tempArray

										available_times_array.push(tempArray[t].text)
										times_array[inc][t] = tempArray[t].text
										
										t += 1

									end

									puts "for day #{temp_day}  of #{month} there are #{available_times_array.length} time slots available #{times_array[inc][0]}, #{times_array[inc][1]}, #{times_array[inc][2]}, #{times_array[inc][3]}, #{times_array[inc][4]}"
									# puts "length of available days: #{available_dates_array.length}"
									# puts "length of available times: #{times_array.length}"

								end


								inc = inc + 1

						 end
		end

		def get_days_of_month()

			days = ["1","2","3","4","5","6","7","8","9","10","11","12",
							"13","14","15","16","17","18","19","20","21","22",
							"23","24","25","26","27","28","29","30","31"]

		end

