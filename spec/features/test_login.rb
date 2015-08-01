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

			days_of_month = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
			  
				 findBookedDays = page.all('.aspNetDisabled')

				 bookedDays = countArrayElements(findBookedDays)

				 inc = 0
				 for i in days_of_month
			
						str = bookedDays.count(days_of_month[inc])

						tempDay = getAvailableDays(str, days_of_month[inc])

						if tempDay != nil
							available_dates.push(tempDay)
						end

						inc = inc + 1

				 end

				 counter = 0
				 for i in available_dates
				 	puts available_dates[counter]
				 	counter +=1
				 end

				 page.find('#MainContent_LinkButtonNext').click
 

	end

end

def countArrayElements(array)
		 inc = 0
		 newArray = []
		 for i in array
				 	newArray.push(array[inc].text)
				 		inc = inc + 1
				 end

		return newArray
end	


def setAugustCalendar()

	 calendar = Array.new
	 calendar = ["27", "28", "29", "30", "31","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","1","2","3","4","5","6"]

	 return calendar

end


def getAvailableDays(str, dayOfMonth)

		if str == 0

			return dayOfMonth

		elsif str == 1

				countDaysOnMontg = setAugustCalendar()

				days = countDaysOnMontg.count(dayOfMonth)

					if days == 2

		  				return dayOfMonth

					end	
		end

end




