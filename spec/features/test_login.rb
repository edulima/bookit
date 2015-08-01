require 'spec_helper'


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

			available_dates = Array.new
			available_times = Array.new

			days_of_month = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
			
			
				 #start of first calendar 
				 findBookedDays = page.all('.aspNetDisabled')

				 bookedDays = countArrayElements(findBookedDays)

				 calculateDays(days_of_month, bookedDays, available_times, available_dates, getCurrentMonth())

				 sleep 3

				 clickNextMonthLink()


				 #start of second calendar
				 findBookedDays = page.all('.aspNetDisabled')

				 bookedDays = countArrayElements(findBookedDays)

				 calculateDays(days_of_month, bookedDays, available_times, available_dates, "sep")


				  sleep 3

				 # inc = 0
				 # for i in days_of_month

				 # 	available_times.clear
			
					# 	str = bookedDays.count(days_of_month[inc])

					# 	tempDay = getAvailableDays(str, days_of_month[inc])
						
					# 	if tempDay != nil

					# 		available_dates.push(tempDay)

					# 		clickOnAvailableDay(tempDay)

					# 		tempArray = getAvailableTime()

					# 		t = 0
					# 		for i in tempArray

					# 			#at this point multi
					# 			available_times.push(tempArray[t].text)

					# 			t += 1

					# 		end

					# 		puts "for day #{tempDay}  of #{find_current_month} there are #{available_times.length} time slots available"

					# 	end

					# 	inc = inc + 1

				 # end

	
				 for i in available_dates

				 	#puts "We found the day: #{available_dates[counter.to_i]} of #{find_current_month}" 

				 end
				 
				 	puts getNextMonth()
				 sleep 5


				 
	end

end

def countArrayElements(array)

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
	 calendar = ["31","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","1","2","3","4"]

	 return calendar

end


def getAvailableDays(str, dayOfMonth, month)

		if str == 0

			return dayOfMonth

		elsif str == 1

					if month == "August"
						
						countDaysOnMontg = setAugustCalendar()
						days = countDaysOnMontg.count(dayOfMonth)

							if days == 2
				  				return dayOfMonth
							end	

					elsif month == "sep"

						countDaysOnMontg = setSeptemberCalendar()
						days = countDaysOnMontg.count(dayOfMonth)

							if days == 2
				  				return dayOfMonth
							end	
						
					end
		end

end

def clickNextMonthLink()

	within("table#MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1") { 
		find(:xpath, "//a[contains(@title, \"next\")]").click }

end

def clickOnAvailableDay(day)

	within("table#MainContent_AppointmentDateTime1_Control_Calendar1_Calendar_Calendar1_Calendar1") { 
		find(:xpath, "//a[contains(@title, \"#{day}\")]").click }

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


def calculateDays(days_of_month, bookedDays, available_times, available_dates, calendar)

	 inc = 0
				 for i in days_of_month

				 	  available_times.clear
			
						countBookedDays = bookedDays.count(days_of_month[inc])

						tempDay = getAvailableDays(countBookedDays, days_of_month[inc], calendar)
						
						if tempDay != nil

							available_dates.push(tempDay)
						
							clickOnAvailableDay(tempDay)

							tempArray = getAvailableTime()

							t = 0
							for i in tempArray

								available_times.push(tempArray[t].text)

								t += 1

							end

							puts "for day #{tempDay}  of #{getCurrentMonth()} there are #{available_times.length} time slots available"

						end

						inc = inc + 1

				 end
end





