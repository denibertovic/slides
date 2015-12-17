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

```python
import logging
logging.basicConfig(format='%(levelname)s : %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
log.setLevel(logging.DEBUG)

try:
    1/0
except:
    log.exception('Some Exception')

```

