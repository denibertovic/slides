Title:   Presentation Title
Author:  Deni Bertovic
Date:    December 09, 2015
Comment: Sample comment
footer:  Sample Footer

## Reveal JS

Some text bla

---

## A slide

Some text bla bla

![Sample Image](md/img/sample_image.png)

---

## A slide below with a list

- A thing
- Another thing
- Three things

---

## Another slide

* Bla
* Bla

---

## Slide with code

```haskell

import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Simple

main :: IO ()
main = do
    response <- httpLBS "http://httpbin.org/get"

    putStrLn $ "The status code was: " ++
               show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    L8.putStrLn $ getResponseBody response
```
