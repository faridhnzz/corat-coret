chance       = 77.7
multiplier   = 1.5
multiplier2  = 1.12
base         = 0.000040
nextbet      = base  
bethigh      = false
target       = .00005
investtarget = .001
tmpprofit    = 0
investprofit = 0
wincount     = 10
stopnow      = false

function dobet()

tmpprofit += currentprofit
investprofit += currentprofit

   if win then
   print("We Won")
      if (tmpprofit > target) then
      print("if tmpprofit is greater than tartget reset to base")
         tmpprofit = 0
         nextbet = base 
         if(stopnow) then stop() end
         if(investprofit  > investtarget ) then
             investprofit = 0
             invest(investtarget)
         end      
      else
      print("Since we lost we are now times our last bet by multiplier2")
         nextbet=previousbet*multiplier2
         if(nextbet < base) then
            print("since nextbet is less than base base bet")
         nextbet = base end
      end
   else
   print("we lost so we are timzing by multiplier 1")
      nextbet=previousbet*multiplier
      if(nextbet < base) then 
      print("if next bet is less than base bet next bet = base bet")nextbet = base end
   end
end
