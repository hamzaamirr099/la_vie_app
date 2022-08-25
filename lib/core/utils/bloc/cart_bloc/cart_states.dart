abstract class CartStates {}

class InitState extends CartStates {}

class LoadingState extends CartStates {}

class ItemAddedToCart extends CartStates {}

class ItemRemovedFromCart extends CartStates {}

class ChangeTotalPriceState extends CartStates {}
class SuccessFetchOneCartItemState extends CartStates {}
class ErrorFetchOneCartItemState extends CartStates {}
class AmountOfProductChanged extends CartStates {}









