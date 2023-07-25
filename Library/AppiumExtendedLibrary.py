# import subprocess
import platform
from appium.webdriver.appium_service import AppiumService
from appium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from robot.libraries.BuiltIn import BuiltIn
from time import sleep
from appium.webdriver.common.touch_action import TouchAction
import time
from appium.webdriver.common.appiumby import AppiumBy
import base64


class AppiumExtendedLibrary(object):
        
        def __init__(self):   
            pass
        
        @property
        def _appium_lib(self):
            return BuiltIn().get_library_instance('AppiumLibrary')

        @property
        def _driver(self):
            return self._appium_lib._current_application()

        def javascript_click_by_xpath(self,xpath):
            element = self._driver.find_element_by_xpath(xpath) 
            self._driver.execute_script("arguments[0].click();", element)

        def start_appium_server(self):
            service = AppiumService()
            service.start()   
        
        def stop_appium_server(self) :
            try:
                platform_name = platform.system()
                if platform_name == 'Windows' :
                   args = ['taskkill' , '/f' , '/IM' , 'node.exe']
                elif platform_name == 'darwin' :
                     args = ['killall' , 'node']
                subprocess.Popen(args=args)                
                return True
            except Exception as e:
                print (e)    
                return False
        
        """def swipe_down(self, swipe_count=2): 
            for count in range(swipe_count):
                self._appium_lib.swipe(700, 1500, 700, 400)
                time.sleep(1)
            return None
                
        def swipe_up_to_element(self, locator=None, swipe_count=2):
            element_status = False 
            for count in range(swipe_count):
                element_status = self.is_element_visible(locator)
                if element_status == False:
                   self._appium_lib.swipe(700, 400, 700, 1500)
                   print("scrolling done")
                else:
                   return element_status   
            return self.is_element_visible(locator)"""
                
        def swipe_down_to_element(self, locator=None, swipe_count=2):
            by_type_and_locator = self.get_element_bytype_and_value(locator)
            by_type = by_type_and_locator[0]
            by_locator = by_type_and_locator[1]
            element_status = False 
            for count in range(swipe_count):
                element_status = self.is_element_visible(locator)
                if element_status == False:
                    platform_name = BuiltIn().get_variable_value("${PLATFORM_NAME}")
                    if platform_name == 'Android':
                        self._appium_lib.swipe(530, 1700, 530, 700)
                    else:
                        self._appium_lib.swipe(189, 650, 189, 370)
                else:
                    print("scroll is enough, element found ", locator)
                    return element_status   
            return self.is_element_visible(locator)
            
        def is_element_visible(self, locator):
            try:
                #To use this function please comment this line self.log_source(loglevel) under function element_should_be_visible
                #in site-packages/AppiumLibrary/keywords/_elements.py
                #self._appium_lib.element_should_be_visible(locator)
                longWait = BuiltIn().get_variable_value("${ELEMENT_VISIBLE_WAIT_TIME}")
                longWait = int(longWait)
                by_type_and_locator = self.get_element_bytype_and_value(locator)
                by_type = by_type_and_locator[0]
                by_locator = by_type_and_locator[1]
                WebDriverWait(self._driver, longWait).until(EC.visibility_of_element_located((by_type, by_locator)))
                # if locator.startswith("//") or locator.startswith("(//"):
                #     element = self._driver.find_element_by_xpath(locator).is_displayed()
                # elif locator.startswith("nsp"):
                #     element = self._driver.find_element_by_ios_predicate(locator[4:]).is_displayed()
                # else:
                #     element = self._driver.find_element_by_accessibility_id(locator[17:]).is_displayed()    
                return True
            except Exception as e:
               print(e)
               return False
        
        def click_image(self, pathofimage):
            el = self._driver.find_element_by_image(pathofimage)
            el.click()
           
        def clear_text_field(self):
            for count in range(32):
                self._appium_lib.press_keycode(67)

        def long_press(self):
            actions = TouchAction(self._driver)
            actions.long_press(element)
            actions.perform()

        def swipe_the_task(self, endx, endy, startx, starty,direction="left"):
            """This function use to swipe left/right on the Task."""
            touchAction = TouchAction(self._driver)
            if(direction=="left"):
                    self._driver.swipe(startx, starty,endx, endy)
            else:
                    self._driver.swipe(endx, endy, startx, starty)

        def go_back(self):
            self._driver.back()

        def click_element_using_accessibility_id(self, accessibilityId):
            element = self._driver.find_elements(AppiumBy.ACCESSIBILITY_ID, accessibilityId)
            element.click()

        def click_element_using_accessibility_id(self, locator):
            by_type_and_locator = self.get_element_bytype_and_value(locator)
            by_type = by_type_and_locator[0]
            by_locator = by_type_and_locator[1]            
            #element = self.get_element_locator(locator)
            
            element = self._driver.find_elements(by_type_and_locator[0], by_type_and_locator[1] )
            element.click()

        def wait_until_element_visible(self,locator):
            """ An Expectation for checking that an element is either invisible or not present on the DOM."""
            longWait = BuiltIn().get_variable_value("${ELEMENT_VISIBLE_WAIT}")
            longWait = int(longWait)
            by_type_and_locator = self.get_element_bytype_and_value(locator)
            by_type = by_type_and_locator[0]
            by_locator = by_type_and_locator[1]
            self.swipe_down_to_element(locator)
            WebDriverWait(self._driver, longWait).until(EC.visibility_of_element_located((by_type_and_locator[0], by_type_and_locator[1])))
            return True
            
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
                        if locator_type == "aid":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_accessibility_id(locator_value) if (status == True) else self.swipe_down_to_element(locator)
                        elif locator_type == "name":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_name(locator_value) if (status == True) else self.swipe_down_to_element(locator)               
                        elif locator_type == "classname":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_class_name(locator_value) if (status == True) else self.swipe_down_to_element(locator)             
                        elif locator_type == "css":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_css_selector(locator_value) if (status == True) else self.swipe_down_to_element(locator)            
                        elif locator_type == "xpath":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_xpath(locator_value) if (status == True) else self.swipe_down_to_element(locator)
                        elif locator_type == "linktext":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_link_text(locator_value) if (status == True) else self.swipe_down_to_element(locator)
                        elif locator_type == "tagname":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_tag_name(locator_value) if (status == True) else self.swipe_down_to_element(locator)
                        elif locator_type == "partiallinktext":
                                status = self.wait_until_element_visible(locator)
                                return self._driver.find_element_by_partial_link_text(locator_value) if (status == True) else self.swipe_down_to_element(locator)
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
                        if locator_type == "aid":
                                return [AppiumBy.ACCESSIBILITY_ID, locator_value]
                        elif locator_type == "name":
                                return [AppiumBy.NAME, locator_value]               
                        elif locator_type == "classname":
                                return [AppiumBy.CLASS_NAME, locator_value]             
                        elif locator_type == "css":
                                return [AppiumBy.CSS_SELECTOR, locator_value]              
                        elif locator_type == "xpath":
                                return [AppiumBy.XPATH, locator_value]
                        elif locator_type == "image":
                                return [AppiumBy.IMAGE, locator_value]
                        elif locator_type == "tagname":
                                return [AppiumBy.TAG_NAME, locator_value]
                        elif locator_type == "android_uiautomator":
                                return [AppiumBy.ANDROID_UIAUTOMATOR, locator_value]
                        elif by_type == 'ios_uiautomation':
                                return (AppiumBy.IOS_UIAUTOMATION, locator_value)
                        elif by_type == 'ios_predicate':
                                return (AppiumBy.IOS_PREDICATE, locator_value)                          
                except ValueError:
                                print("Given "+str(locator_type)+"  locator type is not valid")
                                return False

        def push_file(self, local_file):
            dest_path = '/sdcard/Pictures/qa_test.png'
            #data = bytes(local_file, 'utf-8')
            
            data = bytes(local_file, "utf-8")
            #data = local_file
            self._driver.push_file(dest_path, base64data=base64.b16encode(data).decode('utf-8'))





