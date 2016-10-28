class TicketOrderMailer < ApplicationMailer
  default :from => 'no-reply@theater.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def ticket_order_email(screening, ticket_order)
    @movie_screening = screening
    @ticket_order = ticket_order
    
    mail( :to => @ticket_order.email,
    :subject => 'Movie Ticket Order Receipt' )
  end
end
