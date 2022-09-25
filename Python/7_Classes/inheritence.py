class camera:
    def __init__(self) -> None:
        print(" Modern Camera")
        pass
    def click(self):
        print(" click photo")
        pass
    def video(self):
        print("record videos")
        pass
    pass


class canon(camera):                    # Inherited camera class 
    def __init__(self) -> None:
        super().__init__()                  # call to super class constructor
        print(" Camera created")
        pass
    pass


dslr = camera()
dslr.click()
dslr.video()
can = canon()
can.click()                                 # can acess all functions of Super class
