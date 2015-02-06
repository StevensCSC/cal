#Weronika Zamlynny
#2-3-2015

# calling cal() will print the current month and year
# calling calOpt(month,year) allows you to choose any month and year

import datetime

#Jan 1, 2015 is a Thursday(4)
baseYear = 2015
baseMonth = 1
baseDay = 4

MonthNum = { 1:"January", \
             2:"February", \
             3:"March", \
             4:"April", \
             5:"May", \
             6:"June", \
             7:"July", \
             8:"August", \
             9:"September", \
             10:"October", \
             11:"November", \
             12:"December" }
MonthDays = [0,31,28,31,30,31,30,31,31,30,31,30,31]
Week = ["Su","Mo","Tu","We","Th","Fr","Sa"]

def cal ():
    '''Displays the current month'''
    current= datetime.datetime.now()
    calHelp(current.month, current.year)

def calOpt(month, year):
    '''Takes an integer for both month and year. Displays the month and year selected.'''
    calHelp(month, year)

def calHelp(month, year):
    '''Function used by both cal and calOpt, executes cal'''
    #prints the month and year header
    if MonthNum.has_key(month):
        print "  " + MonthNum[month] + " " + str(year)
    else:
        return False
    #prints the days of the week header
    w = ""
    for day in Week:
        w += day + " "
    print w

    #determines how many blank spaces the calendar needs
    start = startDay(month, year, 0) 
    calendar = []
    if  start != 0:
        for i in range(start):
            calendar += [0]
    for i in range(1,MonthDays[month]+1): 
        calendar += [i]

    weekNum = ""
    j = 1#counting spaces past
    for day in calendar:
        if day == 0:
            weekNum += ("   ")
        elif j % 7 != 0:
            if day <10:
                weekNum += (" "+str(day)+" ")
            else:
                weekNum += (str(day)+" ")
        else:
            if day <10:
                weekNum += (" "+str(day)+" ")
            else:
                weekNum += (str(day)+" ")
            print weekNum
            weekNum = ""
        j += 1
    print weekNum

def startDay (month, year, daysOff):
    '''Determines day of the week of the first day of the month'''
    #years between date and reference
    if year != baseYear:
        if year > baseYear: #back in time
            if month > 2 and year % 4 == 0 and year % 100 == 0 and year % 400 == 0: # the current year is a leap year
                return startDay(month, year-1, daysOff + 366)
            elif month <= 2 and (year-1) % 4 == 0 and (year-1) % 100 == 0 and (year-1) % 400 == 0: # the previous year was a leap year
                return startDay(month, year-1, daysOff + 366)
            else:
                return startDay(month, year-1, daysOff + 365)
        elif year < baseYear:# forward in time
            if month <= 2 and year % 4 == 0 and year % 100 == 0 and year % 400 == 0: # the current year is a leap year
                return startDay(month, year+1, daysOff - 366)
            elif month > 2 and (year+1) % 4 == 0 and (year+1) % 100 == 0 and (year+1) % 400 == 0: # the following year is a leap year
                return startDay(month, year+1, daysOff - 366)
            else:
                return startDay(month, year+1, daysOff - 365)
    #months between
    elif month != baseMonth:
        if month > baseMonth:
            return startDay(month - 1, year, daysOff + MonthDays[month-1])
        elif month < baseMonth:
            return startDay(month + 1, year, daysOff - MonthDays[month])

    else: # same month and year
        return (baseDay + daysOff) % 7
    
        


    
    
    
