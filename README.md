[![R](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)](https://github.com/search?q=owner%3Anevmenandr+lang%3AR+&type=repositories)

# Universitates Podcast Data

[![CRAN status](https://www.r-pkg.org/badges/version/UniversitatesPodcastData.png)](https://cran.r-project.org/package=UniversitatesPodcastData) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%203%29-brightgreen.svg?style=flat)](https://www.gnu.org/licenses/gpl-3.0.ru.html) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX) [![Telegram](https://img.shields.io/badge/channel-on%20Telegram-2ba2d9.svg)](https://t.me/universitates_podcast)

An R package for downloading, extracting, and analyzing interview transcripts from the [Universitates podcast series](https://nevmenandr.github.io/universitates/). It provides tools for data processing, searching, and visualization

## :writing_hand: Author

* Russian CV: https://nevmenandr.github.io/
* English CV: https://nevmenandr.github.io/homepage/
* Full Russian lists and descriptions: http://nevmenandr.net/bo.php

## 📥 Installation
To install the package from CRAN (once submitted and approved):

```r
install.packages("UniversitatesPodcastData")
```

To install the development version from GitHub:

```r
# install.packages("devtools")  # Uncomment if devtools is not installed
devtools::install_github("your-github-username/UniversitatesPodcastData")
```

## 🔧 Functions

### Downloading Webpages

#### `download_podcast_pages(ids)`

Downloads interview pages and extracts structured data.
- **Parameters**: `ids` – a vector of page numbers.
- **Returns**: A list containing extracted data.

### 📊 Extracting Data

#### `extract_podcast_date(page)`

Extracts the publication date from a webpage.
- **Parameters**: `page` – parsed HTML content.
- **Returns**: A date string.

#### `extract_interlocutor_name(page)`

Extracts the interviewee's name.
- **Returns**: A string containing the name.

#### 🧑‍🔬 `extract_interlocutor_specialty(page)`

Extracts the interviewee's specialty.
- **Returns**: A string with the specialty.

#### 🏛️ `extract_interlocutor_universities(page)`

Extracts the universities associated with the interviewee.
- **Returns**: A list of university names.

### 💾 Saving Data

#### `save_data_to_json(data, file)`

Saves extracted data to a JSON file.
- **Parameters**:  
  - `data` – structured data to save.  
  - `file` – output file path.

### 🔍 Searching and Filtering

#### `find_pages_by_specialty(specialty, data)`

Finds interview pages by specialty.
- **Returns**: A vector of page numbers.

#### `find_pages_by_university(university, data)`

Finds interview pages by university.
- **Returns**: A vector of page numbers.

## Usage Example

```r
library(UniversitatesPodcastData)

# Download and extract data for pages 1 and 2
data <- download_podcast_pages(c(1, 2))

# Save to JSON
save_data_to_json(data, "podcast_data.json")

# Find pages by specialty
physics_pages <- find_pages_by_specialty("Кандидат исторических наук", data)

# Find pages by university
mit_pages <- find_pages_by_university("МГУ", data)
```

## Usage in Russian

[In Russian](./Usage-rus.md)

## License

This package is licensed under the GPL-3 license.

## Citation info

### Chicago Style (17th edition, Author-Date)

**Reference list entry:**

Orekhov, Boris. 2025. *Universitates Podcast Data.* Version 1.0.0. https://github.com/nevmenandr/UniversitatesPodcastData.

**In-text citation:** 

(Orekhov 2024)

### ГОСТ Р 7.0.5–2008 (автор-датировка, для онлайн-ресурсов)

Орехов, Б. Universitates Podcast Data [Электронный ресурс] / Б. Орехов. – Версия 1.0.0. – 2025. – URL: https://github.com/nevmenandr/UniversitatesPodcastData (дата обращения: 21.03.2025).

### BibTeX entry for LaTeX users

```latex
@software{Orekhov_UniversitatesPodcastData_2025,
  author = {Boris Orekhov},
  title = {Universitates Podcast Data},
  year = {2025},
  version = {1.0.0},
  url = {https://github.com/nevmenandr/UniversitatesPodcastData},
  orcid = {0000-0002-9099-0436},
  license = {GPL-3.0},
  abstract = {An R package for downloading, extracting, and analyzing interview transcripts from the Universitates podcast series. It provides tools for data processing, searching, and visualization.}
}
```
