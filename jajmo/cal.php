<?php
	class Cal {

		/**
		 * The width of the calendar
		 */
		const WIDTH = 20;

		/**
		 * @var string[] $months The months of the year
		 */
		private static $months = ["January"   => 31, 
					  "February"  => 28, 
					  "March"     => 31, 
					  "April"     => 30, 
					  "May"       => 31, 
					  "June"      => 30, 
					  "July"      => 31, 
					  "August"    => 31, 
					  "September" => 30, 
					  "October"   => 31, 
					  "November"  => 30, 
					  "December"  => 31];

		/**
		 * @var string $month The month to render
		 */
		private static $month;

		/**
		 * @var int $day The day of the month to render
		 */
		private static $day;

		/**
		 * @var int $year The year to render
		 */
		private static $year;

		/**
		 * Setup an instance with no command line arguments
		 */
		public static function nullInstance() {
			self::createInstance(null);
		}

		/**
		 * Setup an instance of the calendar
		 *
		 * @param mixed[] $argv Optional command line arguments
		 */
		public static function createInstance($argv) {
			if(isset($argv[1]) && array_key_exists($argv[1], self::$months)) {
				self::$month = $argv[1];
			} else {
				self::$month = date('F');
			}
			if(isset($argv[2]) && $argv[2] <= self::$months[self::$month]) {
				self::$day = $argv[2];
			} else {
				self::$day = date('j');
			}
			self::$year = date('Y');
			self::render();
		}

		/**
		 * Render the calendar
		 */
		private static function render() {
			self::centerMonth();
			self::renderWeekdays();
			self::renderDays();
			echo "\n";
		}

		/**
		 * Center the month on the calendar
		 */
		private static function centerMonth() {
			$length = strlen(self::$month) + strlen(self::$year) + 1;
			$spaces = self::WIDTH - $length;
			for($i = 0; $i < floor($spaces / 2); $i++) {
				echo " ";
			}
			echo self::$month . " " . self::$year . "\n";
		}

		/**
		 * Render the days of the week
		 */
		private static function renderWeekdays() {
			echo "Su ";
			echo "Mo ";
			echo "Tu ";
			echo "We ";
			echo "Th ";
			echo "Fr ";
			echo "Sa\n";
		}

		/**
		 * Render the days of the month
		 */
		private static function renderDays() {
			for($i = 1; $i <= self::$months[self::$month]; $i++) {
				if($i < 10) {
					if($i % 7 == 1) {
						echo " ";
					} else {
						echo "  ";
					}
				} else {
					if($i % 7 != 1) {
						echo " ";
					}
				}
				if($i == self::$day) {
					echo self::invert($i);
				} else {
					echo $i;
				}
				if($i % 7 == 0) {
					echo "\n";
				}
			}
		}

		/**
		 * Invert the background and text colors of a string
		 *
		 * @param string $num The string to invert
		 * @return string The inverted string
		 */
		private static function invert($num) {
			$newStr = "\033[47m\033[30m" . $num . "\033[0m";
			return $newStr;
		}
	}

	Cal::createInstance($argv);
?>