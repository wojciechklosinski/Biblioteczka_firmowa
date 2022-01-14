# README

Aplikacja biblioteczka firmowa, zapraszam do użytkowania!

## O aplikacji
Do aplikacji można się zalogować jako administrator lub jako zwykły użytkownik.
Zalogowany użytkownik ma możliwość:
- zobaczenia spisu książek (zakładka "Spis książek") możliwych do wypożyczenia, wraz ze szczegółami (okładka, opis),
- wypożyczenia danej książki (po wypożyczeniu danej książki, użytkownik ma możliwość zobaczenia jej treści),
- zwrotu książki (w momencie zwrotu dług użytkownika zostanie powiększony o iloczyn dni wypożyczenia książki oraz cenę książki),
- sprawdzenia jakie książki aktualnie wypożycza (zakładka "Konto" -> "Profil"),
- sprawdzenia hisotrii wypożyczonych książek (zakładka "Konto" -> "Historia wypożyczeń"). 

Ponadto, administrator może:
- dodawać, edytować i usuwać książki,
- resetować dług użytkowników (zakładka "Zarządzaj użytkownikami").

Aplikacja umożliwia logowanie za pomocą konta Google.
 
## Uruchomienie aplikacji

Aby uruchomić aplikację postępuj zgodnie z poniższą instrukcją.

Po pobraniu repozytorium w wierszu poleceń przejdź do katalogu repozytorium (w tym przypadku katalog powinien się nazywać "Biblioteczka-firmowa".
Następnie wpisz poniższą komendę, aby zainstalować gems'y wymagane przez aplikację: 

```ruby
bundle install --without production
```
Kolejnym krokiem jest migracje bazy danych oraz jej wstępne wypełnienie. Wpisz kolejne komendy
```ruby
rails db:migrate
```
```ruby
rails db:seed
```


Pozostało uruchomić serwer za pomocą komendy:
```ruby
rails server
```


