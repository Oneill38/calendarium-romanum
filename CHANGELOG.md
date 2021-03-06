# Changelog

## [0.4.0] 2017-09-02

### Fixed

- `Sanctorale#replace` saving the supplied array as part of
  the internal data structures (and thus allowing their -
  usually unintentional - modification by external code)
- `Calendar` unintentionally modifying `Sanctorale` internal data
  when handling optional memorials
- errors in English ordinals greater than 10 ("21th" -> "21st" etc.)
- `Ranks::FERIAL.memorial?` wrongly returning `true`
- rank of *All Souls* fixed in all data files

### Added

- support for transfer of Epiphany, Ascension and Corpus Christi
  to a Sunday (GNLYC 7)
- General Roman Calendar in French and French localization
  (by Azarias Boutin @AzariasB)
- `PerpetualCalendar`
- `Season#name`, `Colour#name` - localized human-readable names

### Changed

- interface for `Temporale` extensions changed completely:
  extensions are self-contained, isolated; their sole responsibility
  is to yield data
- `Calendar` stripped of the ability to create new instances
  with the same settings:
  - `Calendar#pred` and `#succ` removed
  - `Calendar.new` receives `Temporale` *instance*
    (instead of a temporale factory)
- `Calendar#day` raises `RangeError` if the day is earlier than
  1st January 1970 (day of introduction of the implemented calendar
  system)
- `Temporale::Dates.easter_sunday` doesn't return Julian calendar
  Easter date for years <= 1752 (this library isn't intended to be used
  for years earlier than 1970)
- `Day#==` and `Calendar#==` test object contents, not identity
- `Temporale::Dates.body_blood` renamed to `.corpus_christi`
- `Sanctorale#freeze` freezes also the internal data structures
- `Calendar#freeze` freezes contained `Temporale` and `Sanctorale`
- seasons and colours indexed by their symbols, not by index number -
  e.g. `Seasons[:lent]`, `Colours[:violet]`
- `Calendar#celebrations_for` made private

## [0.3.0] 2017-08-07

### Fixed

*This is a feature release - bugs were only introduced, not fixed :)*

### Added

- `Celebration#title` is now being generated for all Sundays and
  ferials (was empty)
- ferials of the Holy Week and of the last week of Advent
  have proper ranks
- new rank `Ranks::COMMEMORATION` introduced;
  during privileged seasons, suppressed memorials, which
  can be commemorated in the Divine Office (see GILH 239),
  appear in `Day#celebrations` with this rank
- memorial of the *Immaculate Heart of Mary*
  (although it really belongs to the sanctorale, as a movable feast
  it is implemented in `Temporale`)
- support for extending `Temporale` with additional feasts
  (`Temporale.with_extensions`, `Temporale.add_celebration`,
  additional optional argument accepted by `Calendar.new` and
  `Calendar.for_date`)
- `Temporale::Extensions::ChristEternalPriest` - `Temporale` extension
  implementing the feast of *Christ the Eternal Priest*,
  celebrated in some dioceses and religious institutes
  on Thursday after Pentecost
- `Temporale::Dates` - module containing all the
  temporale-solemnity-date-computing algorithms used in `Temporale`
- `Temporale#year`
- sanctorale data files may have YAML front matter
  (a YAML document with metadata placed before the main content)

### Changed

- seasons and colours are represented by `Season` and `Colour`
  instances, not by `Symbol`s
- `Temporale#advent_sunday` and most `#*_advent_sunday`
  removed, only `Temporale#first_advent_sunday` remains
- `Temporale#weekday_before`, `#weekday_after`, `#octave_of`,
  `#monday_before` etc., `#monday_after` etc. removed
  (all these general date helpers now reside in `Temporale::Dates`)
- unused attribute `Day#vespers` removed
- `Temporale#concretize_abstract_date` removed

## [0.2.1] 2017-07-21

### Fixed

- `AbstractDate` validity checks refusing 29th February

## [0.2.0] 2017-07-20

### Fixed

- numbering of Ordinary Time Sundays after Pentecost
- `Calendar#day` when an instance of `DateTime` is supplied as argument
- minor fixes in data files
- `calendariumrom` executable (broken in recent releases)

### Added

- missing *temporale* feast days: Ash Wednesday, Palm Sunday, Ascension,
- new bundled locales: Latin, Italian, Czech
- contents of `Seasons`, `Ranks` and `Colours` can be explored via `each` and `all`
- bundled data files easily accessible through `CalendariumRomanum::Data`

### Changed

- `Rank` never more inherits from `Struct`
- `Seasons`, `Ranks` and `Colours` changed from modules to classes
- `Sanctorale` raises `ArgumentError` on attempt to load two celebrations of rank other than optional memorial on a single day
- data file format: rank letter is optional when the rank is specified by number
- data file format: rank and colour letters are treated case-insensitively

## [0.1.0] 2017-02-25

### Fixed
- computing date of Holy Family when there is no Sunday between December 25th and January 1st (by Eddy Mulyono @eddymul)
- missing information for some celebrations added to the General Roman Calendar in English (by Andrea Ferrato @ferra-andre)

### Added
- General Roman Calendar in Italian (by Andrea Ferrato @ferra-andre)
- `CalendariumRomanum::SanctoraleFactory` for loading of layered sanctorale calendars
- `Rank#short_desc` value for unprivileged Sunday and privileged ferial
- Temporale feast titles and some other strings can be translated (gem `i18n` used)

### Changed
- [breaking change] `SanctoraleLoader#load` argument order changed

## [0.0.3] 2016-08-27

### Fixed
- fatal constant reference bug in `Temporale`
- the specs that covered it

## [0.0.2] 2016-08-27 YANKED

release yanked, as it contained a fatal bug in `Temporale`,
resulting in `NameError` being raised on each initialization

### Fixed
- all celebrations handled by `Temporale` purged from the sanctorale
  data files. Note that having temporale *solemnities* in sanctorale
  data results in these being duplicated due to the transfer of
  impeded solemnities.
- rank of Mary Magdalene updated in the sanctorale data files
- rank of the feast of the Holy Family fixed

### Changed
- solemnity of Mary, Mother of God (January 1st) is handled by
  `Temporale`

## [0.0.1] 2016-08-20

### Added
- transfer of impeded solemnities

### Changed
- sanctorale data must be loaded before `Calendar` initialization
- `Calendar#sanctorale` is read-only
- dropped `Calendar.day`, `Sanctorale#validate_date`
- `SanctoraleLoader` raises exceptions on errors (instead of writing invalid entries to a log and skipping them)
