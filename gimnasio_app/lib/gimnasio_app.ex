defmodule GimnasioApp do
  use Application

  def start(_type,_args) do
    Menu.main()
    {:ok,self()}
  end

end
