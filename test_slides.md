## Reveal JS

Deni Bertovic


## A slide


## A slide below with a list

 - A thing
 - Another thing
 - Three things

## Another slide

 * Bla
 * Bla

## Slide with code

    import logging

    logging.basicConfig(format='%(levelname)s : %(message)s', level=logging.DEBUG)
    log = logging.getLogger(__name__)
    log.setLevel(logging.DEBUG)

    try:
        1/0
    except:
        log.exception('DINAMOOOOOO')


