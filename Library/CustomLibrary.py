from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException
import xlrd
import calendar
import time
import re
import configparser
import os
import random
import string
import names
from appdirs import user_data_dir
from selenium.webdriver.common.keys import Keys
from datetime import datetime
from dateutil.relativedelta import relativedelta
from selenium.webdriver import ActionChains
from datetime import date
from datetime import timedelta
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from webdriver_manager.microsoft import IEDriverManager
from webdriver_manager.firefox import GeckoDriverManager
import requests
import json

class CustomLibrary(object):

        def __init__(self):
                pass

        @property
        def _sel_lib(self):
            return BuiltIn().get_library_instance('SeleniumLibrary')

        @property
        def _driver(self):
            return self._sel_lib.driver
        
        def open_chrome_browser(self,url,headless="False",clear_cache="False"):
            """Return the True if Chrome browser opened """
            selenium = BuiltIn().get_library_instance('SeleniumLibrary')
            try:                
                options = webdriver.ChromeOptions()
                options.add_argument("--disable-extensions")
                options.add_argument('--no-sandbox')
                options.add_argument('--disable-dev-shm-usage')
                options.add_experimental_option("excludeSwitches",["enable-automation","load-extension"])
                prefs = {"credentials_enable_service": False,"profile.password_manager_enabled": False,"profile.default_content_setting_values.notifications" : 2}
                options.add_experimental_option("prefs", prefs)
                if headless=="True":
                        options.add_argument("--headless")
                        options.add_argument("--window-size=1400,600");
                #options.add_argument("user-data-direc=" + self.get_chrome_profile_path()) #Path to your chrome profile, Used WebDriverManager class to handle chrome driver configuration.
                selenium.create_webdriver('Chrome', executable_path=ChromeDriverManager().install(), chrome_options=options)
                selenium.go_to(url)
                print(clear_cache)                
                if clear_cache=="True":
                        self._driver.delete_all_cookies()
            except Exception as e:
                raise e

        def open_firefox_browser(self,url,headless="False"):
            """Return the True if Firefox browser opened """
            selenium = BuiltIn().get_library_instance('SeleniumLibrary')
            try:
                options = webdriver.FirefoxOptions()
                options.add_argument("disable-extensions")                
                #options.add_experimental_option("excludeSwitches",["enable-automation","load-extension"])
                prefs = {"credentials_enable_service": False,"profile.password_manager_enabled": False,"profile.default_content_setting_values.notifications" : 2}
                #options.add_experimental_option("prefs", prefs)
                if headless=="True":
                        options.add_argument("--headless")
                        options.add_argument("--window-size=1400,600");
                #options.add_argument("user-data-direc=" + self.get_chrome_profile_path()) #Path to your chrome profile, Used WebDriverManager class to handle chrome driver configuration.
                selenium.create_webdriver('Firefox', executable_path=GeckoDriverManager().install(), firefox_options=options)
                selenium.go_to(url)
            except Exception as e:
                raise e

        def open_ie_browser(self,url,headless="False"):
            """Return the True if IE browser opened """
            selenium = BuiltIn().get_library_instance('SeleniumLibrary')
            try:
                options = webdriver.IeOptions()
                options.add_argument("disable-extensions")                
                options.add_experimental_option("excludeSwitches",["enable-automation","load-extension"])
                prefs = {"credentials_enable_service": False,"profile.password_manager_enabled": False,"profile.default_content_setting_values.notifications" : 2}
                options.add_experimental_option("prefs", prefs)
                if headless=="True":
                        options.add_argument("--headless")
                        options.add_argument("--window-size=1400,600");
                #options.add_argument("user-data-direc=" + self.get_chrome_profile_path()) #Path to your chrome profile, Used WebDriverManager class to handle chrome driver configuration.
                selenium.create_webdriver('Ie', executable_path=IEDriverManager().install(), options=options)
                selenium.go_to(url)
            except Exception as e:
                raise e

        def open_edge_browser(self,url,headless="False"):
            """Return the True if edge browser opened """
            selenium = BuiltIn().get_library_instance('SeleniumLibrary')
            try:
                options = webdriver.EdgeOptions()
                options.add_argument("disable-extensions")                
                options.add_experimental_option("excludeSwitches",["enable-automation","load-extension"])
                prefs = {"credentials_enable_service": False,"profile.password_manager_enabled": False,"profile.default_content_setting_values.notifications" : 2}
                options.add_experimental_option("prefs", prefs)
                if headless=="True":
                        options.add_argument("--headless")
                        options.add_argument("--window-size=1400,600");
                #options.add_argument("user-data-direc=" + self.get_chrome_profile_path()) #Path to your chrome profile, Used WebDriverManager class to handle chrome driver configuration.
                selenium.create_webdriver('Edge', executable_path=EdgeChromiumDriverManager().install(), options=options)
                selenium.go_to(url)
            except Exception as e:
                raise e

        def open_the_browser(self,url,headless="False",browser_name="gc"):
            """Return the True if browser opened """
            if(browser_name=='chrome' or browser_name=='gc' or browser_name=='google chrome' or browser_name=='Chrome'):
                    self.open_chrome_browser(url,headless)
            elif(browser_name=='firefox' or browser_name=='Firefox'):
                    self.open_firefox_browser(url,headless)
            elif(browser_name=='ie' or browser_name=='IE' or browser_name=='InternetExplorer'):
                    self.open_ie_browser(url,headless)
            elif(browser_name=='edge' or browser_name=='Edge'):
                    self.open_edge_browser(url,headless)
           
        def get_current_date_with_increment_days(self, daysToIncrease):
            """ Returns the current date with increased days in the format month date year"""
            print(daysToIncrease)
            daysToIncrease = int(daysToIncrease)
            date_after_days = datetime.now() + relativedelta(days=daysToIncrease)
            date = date_after_days.strftime('%Y/%d/%m')
            return date     

        def scrol_down_page(self, locator):
            element = self.get_element_locator(locator)
            element.send_keys(Keys.PAGE_DOWN)
        
        def javascript_click(self,locator):
            element = self.get_element_locator(locator) 
            self._driver.execute_script("arguments[0].click();", element)   

        def wait_until_time(self,arg):
                time.sleep(int(arg))
                
        def get_chrome_profile_path(self):
                chrome_profile_path= user_data_dir('Chrome','Google') + '\\User Data'
                return chrome_profile_path

        def check_exists_by_xpath(self,xpath):
            try:
                self._driver.find_element_by_xpath(xpath)
            except NoSuchElementException:
                return False
            return True
        
        def input_text(self,xpath,value):
                element = self.get_element_locator(xpath)
                try:
                        element.send_keys(value)
                except NoSuchElementException:
                        return ""
        

        def get_element_attribute(self,xpath,attr):
                element = self.get_element_locator(xpath)
                try:
                        return element.get_attribute(attr) 
                except NoSuchElementException:
                        return ""
            
        def get_ms_excel_row_values_into_dictionary_based_on_key(self,filepath,keyName,sheetName=None):
            """Returns the dictionary of values given row in the MS Excel file """
            workbook = xlrd.open_workbook(filepath)
            snames=workbook.sheet_names()
            dictVar={}
            if sheetName==None:
                sheetName=snames[0]      
            if self.validate_the_sheet_in_ms_excel_file(filepath,sheetName)==False:
                return dictVar
            worksheet=workbook.sheet_by_name(sheetName)
            noofrows=worksheet.nrows
            dictVar={}
            headersList=worksheet.row_values(int(0))
            for rowNo in range(1,int(noofrows)):
                rowValues=worksheet.row_values(int(rowNo))
                if str(rowValues[0])!=str(keyName):
                    continue
                for rowIndex in range(0,len(rowValues)):
                    cell_data=rowValues[rowIndex]
                    if(str(cell_data)=="" or str(cell_data)==None):
                        continue
                    if(str(cell_data)=="BLANK"):
                            cell_data = ""
                    cell_data=self.get_unique_test_data(cell_data)
                    cell_data = self.get_random_name_test_data(cell_data)
                    cell_data=self.get_random_number_test_data(cell_data)
                    col_name = str(headersList[rowIndex])              
                    dictVar[col_name]=str(cell_data)
            return dictVar

        def get_all_ms_excel_row_values_into_dictionary(self,filepath,sheetName=None):
            """Returns the dictionary of values all row in the MS Excel file """
            workbook = xlrd.open_workbook(filepath)
            snames=workbook.sheet_names()
            all_row_dict={}
            if sheetName==None:
                sheetName=snames[0]      
            if self.validate_the_sheet_in_ms_excel_file(filepath,sheetName)==False:
                return all_row_dict
            worksheet=workbook.sheet_by_name(sheetName)
            noofrows=worksheet.nrows
            headersList=worksheet.row_values(int(0))
            for rowNo in range(1,int(noofrows)):
                each_row_dict={}
                rowValues=worksheet.row_values(int(rowNo))
                for rowIndex in range(0,len(rowValues)):
                    cell_data=rowValues[rowIndex]
                    if(str(cell_data)=="" or str(cell_data)==None):
                        continue
                    if(str(cell_data)=="BLANK"):
                            cell_data = ""
                    cell_data=self.get_unique_test_data(cell_data)
                    cell_data=self.get_random_number_test_data(cell_data)
                    each_row_dict[str(headersList[rowIndex])]=str(cell_data)
                all_row_dict[str(rowValues[0])]=each_row_dict
            return all_row_dict

        def get_all_ms_excel_matching_row_values_into_dictionary_based_on_key(self,filepath,keyName,sheetName=None):
            """Returns the dictionary of matching row values from the MS Excel file based on key"""
            workbook = xlrd.open_workbook(filepath)
            snames=workbook.sheet_names()
            all_row_dict={}
            if sheetName==None:
                sheetName=snames[0]      
            if self.validate_the_sheet_in_ms_excel_file(filepath,sheetName)==False:
                return all_row_dict
            worksheet=workbook.sheet_by_name(sheetName)
            noofrows=worksheet.nrows
            headersList=worksheet.row_values(int(0))
            indexValue=1
            for rowNo in range(1,int(noofrows)):
                rowValues=worksheet.row_values(int(rowNo))
                if str(rowValues[0])!=str(keyName):
                    continue
                each_row_dict={}
                for rowIndex in range(0,len(rowValues)):
                    cell_data=rowValues[rowIndex]
                    if(str(cell_data)=="" or str(cell_data)==None):
                        continue
                    cell_data=self.get_unique_test_data(cell_data)
                    
                    each_row_dict[str(headersList[rowIndex])]=str(cell_data)
                all_row_dict[str(indexValue)]=each_row_dict
                indexValue+=1
            return all_row_dict

        def get_unique_test_data(self,testdata):
            """Returns the unique if data contains unique word """
            ts = calendar.timegm(time.gmtime())
            unique_string=str(ts)
            testdata=testdata.replace("UNIQUE",unique_string)
            testdata=testdata.replace("Unique",unique_string)
            testdata=testdata.replace("unique",unique_string)
            return testdata

        def get_random_number_test_data(self,testdata):
                num =''.join(random.choices(string.digits, k=4))
                randomNumber=str(num)
                testdata=testdata.replace("RANDOM",randomNumber)
                testdata=testdata.replace("Random",randomNumber)
                testdata=testdata.replace("random",randomNumber)
                return testdata

        def get_random_name_test_data(self,testdata):
                randomText = names.get_first_name()
                testdata=testdata.replace("RANDOMNAME",randomText)
                testdata=testdata.replace("RandomName",randomText)
                testdata=testdata.replace("randomname",randomText)
                return testdata
                
        def validate_the_sheet_in_ms_excel_file(self,filepath,sheetName):
            """Returns the True if the specified work sheets exist in the specifed MS Excel file else False"""
            workbook = xlrd.open_workbook(filepath)
            snames=workbook.sheet_names()
            sStatus=False        
            if sheetName==None:
                return True
            else:
                for sname in snames:
                    if sname.lower()==sheetName.lower():
                        sStatus=True
                        break
                if sStatus==False:
                    print ("Error: The specified sheet: "+str(sheetName)+" doesn't exist in the specified file: " +str(filepath))
            return sStatus
        
        def wait_until_element_is_present(self,locator):
                """ An Expectation for checking that an element is either invisible or not present on the DOM."""
                """ Needs to deprecate this function and use wait_until_element_function function """
                longWait = BuiltIn().get_variable_value("${ELEMENT_VISIBLE_WAIT}")
                longWait = int(longWait)
                by_type_and_locator = self.get_element_bytype_and_value(locator)
                by_type = by_type_and_locator[0]
                by_locator = by_type_and_locator[1]
                WebDriverWait(self._driver, longWait).until(EC.visibility_of_element_located((by_type_and_locator[0], by_type_and_locator[1])))

        def wait_until_element_clickable(self,locator):
                """ An Expectation for checking that an element is either invisible or not present on the DOM."""
                longWait = BuiltIn().get_variable_value("${ELEMENT_VISIBLE_WAIT}")
                longWait = int(longWait)
                by_type_and_locator = self.get_element_bytype_and_value(locator)
                by_type = by_type_and_locator[0]
                by_locator = by_type_and_locator[1]
                time.sleep(2)                
                WebDriverWait(self._driver, longWait).until(EC.element_to_be_clickable((by_type_and_locator[0], by_type_and_locator[1])))               

        def drag_and_drop_the_element(self,source,target):
                """ Drag and Drop an element """
                actionChains = ActionChains(self._driver)
                #actionChains.drag_and_drop(source, target).perform()
                source = self.get_element_locator(source)
                target = self.get_element_locator(target)
                actionChains.click_and_hold(source).pause(4).move_to_element(target).release(target).perform()
  
        def get_previous_date(self,number_of_days):
                """ Get previous date by passing number of days """
                # Get today's date
                today = date.today()
                print("Today is: ", today)
                number_of_days=int(number_of_days)
                # Get +number_of_days+ days earlier
                previous_day = today - timedelta(days = number_of_days)
                return str(previous_day)

        def get_next_date(self,number_of_days):
                """ Get next date by passing number of days """
                # Get today's date
                today = date.today()
                print("Today is: ", today)
                number_of_days=int(number_of_days)
                # Get +number_of_days+ days earlier
                next_day = today + timedelta(days = number_of_days)
                return str(next_day)

        def sorting_list_in_ascending_order(self,list):
                """ Returns the sorted list in ascending order"""
                print(list)
                list.sort()
                print(list)
                return list        
   
        def sorting_list_in_descending_order(self,list):
                """ Returns the sorted list in descending order"""
                print(list)
                list.sort(reverse=True)
                print(list)
                return list       

        def compare_lists(self,first_list,sec_list):
                """ Returns the sorted list in descending order"""
                print(first_list)
                print(sec_list)
                if first_list == sec_list:
                    return True
                else:
                    return False
                
        def moving_slider(self,slider_locator):
                """ moving slder to some extent along x-axis """
                slider = self.get_element_locator(slider_locator)
                move = ActionChains(self._driver)
                move.click_and_hold(slider).move_by_offset(40, 0).release().perform()
                
        def dynamic_wait_until_element_clickable(self,locator,wait_time):
                """ An Expectation for checking that an element is either invisible or not present on the DOM."""
                if locator.startswith("//") or locator.startswith("(//"):
                        print("clickable before")
                        WebDriverWait(self._driver, wait_time).until(EC.element_to_be_clickable((By.XPATH, locator)))
                        print("clickable after")
                else:
                        WebDriverWait(self._driver, wait_time).until(EC.element_to_be_clickable((By.ID, locator)))                

        def dynamic_wait_until_element_clickable_and_click(self,locator,wait_time):
                """ An Expectation for checking that an element is either invisible or not present on the DOM and click the element."""
                wait_time = int(wait_time)
                if locator.startswith("//") or locator.startswith("(//"):                        
                        WebDriverWait(self._driver, wait_time).until(EC.element_to_be_clickable((By.XPATH, locator)))
                        self._driver.find_element_by_xpath(locator).click()                        
                else:
                        WebDriverWait(self._driver, wait_time).until(EC.element_to_be_clickable((By.ID, locator)))                

        '''def get_element_locator(self,locator):
                """ This functions used to get the type of the element
                locator and it will split the locator with : and returns the type of the locator and locator value.
                :param locator: locator of the element """
                try:
                        """Get locator to split """
                        locator_value = locator.split(":", 1)
                        """ Locator type"""
                        locator_type = locator_value[0]
                        """ Locator value"""
                        locator_value = locator_value[1]
                        """ Check the locator type of given locator"""
                        if locator_type == "id":
                                return self._driver.find_element("id", locator_value)
                        elif locator_type == "name":
                                return self._driver.find_element("name",  locator_value)               
                        elif locator_type == "classname":
                                return self._driver.find_element("classname", locator_value)             
                        elif locator_type == "css":
                                return self._driver.find_element("css", locator_value)            
                        elif locator_type == "xpath":
                                return self._driver.find_element("xpath", locator_value)
                        elif locator_type == "linktext":
                                return self._driver.find_element("linktext", locator_value)
                        elif locator_type == "tagname":
                                return self._driver.find_element("tagname", locator_value)
                        elif locator_type == "partiallinktext":
                                return self._driver.find_element("partiallinktext", locator_value)
                except ValueError:
                                print("Given "+str(locator_type)+"  locator type is not valid")
                                return False'''

        def get_element_locator(self,locator):
                """ This functions used to get the type of the element
                locator and it will split the locator with : and returns the type of the locator and locator value.
                :param locator: locator of the element """
                try:
                        """Get locator to split """
                        locator_value = locator.split(":", 1)
                        """ Locator type"""
                        locator_type = locator_value[0]
                        """ Locator value"""
                        locator_value = locator_value[1]
                        """ Check the locator type of given locator"""
                        if locator_type == "id":
                                return self._driver.find_element_by_id(locator_value)
                        elif locator_type == "name":
                                return self._driver.find_element_by_name(locator_value)               
                        elif locator_type == "classname":
                                return self._driver.find_element_by_class_name(locator_value)             
                        elif locator_type == "css":
                                return self._driver.find_element_by_css_selector(locator_value)            
                        elif locator_type == "xpath":
                                return self._driver.find_element_by_xpath(locator_value)
                        elif locator_type == "linktext":
                                return self._driver.find_element_by_link_text(locator_value)
                        elif locator_type == "tagname":
                                return self._driver.find_element_by_tag_name(locator_value)
                        elif locator_type == "partiallinktext":
                                return self._driver.find_element_by_partial_link_text(locator_value)
                except ValueError:
                                print("Given "+str(locator_type)+"  locator type is not valid")
                                return False
                        

        def get_element_bytype_and_value(self,locator):
                """ This functions used to get the type of the element
                locator and it will split the locator with : and returns the type of the locator and locator value.
                :param function_param: This method is to get_element_bytype_and_value 
                :param locator: locator of the element
                :retunrn: locator_type & locator_value
                """
                try:
                        """Get locator to split """
                        locator_value = locator.split(":", 1)
                        """ Locator type"""
                        locator_type = locator_value[0]
                        """ Locator value"""
                        locator_value = locator_value[1]
                        """ Check the locator type of given locator"""
                        if locator_type == "id":
                                return [By.ID, locator_value]
                        elif locator_type == "name":
                                return [By.NAME, locator_value]               
                        elif locator_type == "classname":
                                return [By.CLASS_NAME, locator_value]             
                        elif locator_type == "css":
                                return [By.CSS_SELECTOR, locator_value]              
                        elif locator_type == "xpath":
                                return [By.XPATH, locator_value]
                        elif locator_type == "linktext":
                                return [By.LINK_TEXT, locator_value]
                        elif locator_type == "tagname":
                                return [By.TAG_NAME, locator_value]
                        elif locator_type == "partiallinktext":
                                return [By.PARTIAL_LINK_TEXT, locator_value]
                except ValueError:
                                print("Given "+str(locator_type)+"  locator type is not valid")
                                return False

        def wait_until_element_function(self,locator,condition):
                """ An Expectation for checking that an element is """+condition+""" on the DOM.
                We have to pass element status to validate.
                :param: locator
                :param: condition."""
                longWait = BuiltIn().get_variable_value("${ELEMENT_VISIBLE_WAIT}")
                longWait = int(longWait)
                by_type_and_locator = self.get_element_bytype_and_value(locator)
                by_type = by_type_and_locator[0]
                by_locator = by_type_and_locator[1]
                if(condition=="Visibility"):
                        WebDriverWait(self._driver, longWait).until(EC.visibility_of_element_located((by_type_and_locator[0], by_type_and_locator[1])))
                elif(condition=="Present"):
                        WebDriverWait(self._driver, longWait).until(EC.visibility_of_element_present((by_type_and_locator[0], by_type_and_locator[1])))
                elif(condition=="Clickable"):
                        WebDriverWait(self._driver, longWait).until(EC.element_to_be_clickable((by_type_and_locator[0], by_type_and_locator[1]))) 

        def parse_json_response(self,jsonresponse,key):
            value = json.dumps(jsonresponse[key])
            return value
        
        def parse_array_json_response(self,json_array_response,index,key):
            request_lib = BuiltIn().get_library_instance('RequestsLibrary')
            json_array = request_lib.to_json(json_array_response)
            array_value = json_array[int(index)]
            value = self.parse_json_response(array_value,key)
            return value
          
        def parse_nested_json_response(self,jsonresponse,nestedjsonkey,key):
            value = json.dumps(jsonresponse[nestedjsonkey][key])
            return value
            
        def get_value_from_json(self, json_response, json_path):
            json_path_expr = parse(json_path)
            get_array_value= [match.value for match in json_path_expr.find(json_response)]
            get_value= str(get_array_value)[1:-1]
            return get_value
