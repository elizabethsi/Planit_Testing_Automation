from robot.libraries.BuiltIn import BuiltIn

class CustomKeywords:
  """
    Used to upload multiple files   paths are separated by \n
    The keyword can then be used like: Choose Files | my_upload_field_locator | ${CURDIR}/file_1.csv \n ${CURDIR}/file_2.csv
    credits to user10063250
  """
  def choose_files(self, locator, file_paths):
    sl = BuiltIn().get_library_instance('SeleniumLibrary')
    sl.find_element(locator).send_keys(file_paths)