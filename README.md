# EBCardCollectionViewLayout
Have you ever tried to implement a simple UI showing element as cards?
You ended up implementing a `UIScrollView`, didn't you? Well, you should have used a `UICollectionView` with a custom `UICollectionViewLayout` instead. 

Here's that custom class you need :-)

![Demo](https://github.com/betzerra/EBCardCollectionViewLayout/blob/master/cards.gif)

## Work In Progress
This is not fully tested so create an issue if you are having some kind of trouble.

## Installation
You can use *CocoaPods*
```
pod 'EBCardCollectionViewLayout', :git => 'https://github.com/betzerra/EBCardCollectionViewLayout'
```

Be sure you have disabled _"Enable Pagination"_ on your `UICollectionView`. Otherwise, the pagination will behavior inaccurately. 

Also, to get the card look and feel, you have to set the `EBCardCollectionViewLayout` offset property (see example project for more information): 
```
UIOffset anOffset = UIOffsetMake(20, 0);
[(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
```


##License
This project is under MIT License. See LICENSE file for more information.

Except photos for the demo project which are part of *#portraitwithtongue* by [Adrimontaldovera](http://instagram.com/adrimontaldovera) Those are not under MIT License.
