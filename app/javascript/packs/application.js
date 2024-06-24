import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
require('jquery')
require('custom/habit.js')
require('custom/diaries.js')
