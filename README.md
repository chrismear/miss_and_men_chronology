# Little Miss and Mr Men Chronology

In the Little Miss and Mr Men series of books, it is common for a character in
their titular book to fundamentally change something about themselves. For
example, in the book _Mr Greedy_, Mr Greedy learns to eat less, and becomes thin
instead of fat. However, in other books, the same characters appear as they were
_before_ their change. This implies a chronological ordering of the entire book
series, which is what this program aims to calculate.

## Installation and usage

To run the program using Docker, follow these steps:

1. Clone the repository:
   `git clone https://github.com/chrismear/miss_and_men_chronology.git`
2. Navigate to the project directory: `cd miss_and_men_chronology`
3. Run `docker-compose up --build`
4. View the output graph in `output`.

Or, to run locally:

1. Clone the repository:
   `git clone https://github.com/chrismear/miss_and_men_chronology.git`
2. Navigate to the project directory: `cd miss_and_men_chronology`
3. Install GraphViz (e.g. `brew install graphviz` on macOS with Homebrew)
4. Install Ruby 3.3.3 (e.g. `rbenv install 3.3.3`)
5. Install the project's dependencies: `bundle install`
6. Run the program: `bin/bundle exec ruby miss_and_men_chronology.rb`
7. View the output graph in `output`.

## Contributing

Contributions are welcome! I particularly need help to make sure the data about
characters' changes and appearances in each of the books is accurate and
complete.

If you would like to contribute to this project, please follow these guidelines:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/my-feature`
3. Make your changes and commit them: `git commit -m 'Add my feature'`
4. Make sure the tests pass: `bin/rake`
5. Push your changes to your forked repository:
   `git push origin feature/my-feature`
6. Open a pull request

## License

This project is licensed under the
[GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

Little Miss and Mr Men Chronology
Copyright (C) 2024 Chris Tucker MEar

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
