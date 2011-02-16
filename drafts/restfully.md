# A RESTful HTTP Client

* Can be augmented with unknown media-types
* Provides Item and Collection modules: response.extend(Collection) ?
* Works as a state machine


* Need to semantically define what is a "thing" for a human with the corresponding relationaship.
  Ex: a "job" is represented by a rel="http://whatever.com/job"
  Ex: a "collection" of items is represented by rel="collection"
  
* The client defines 

  rennes = find :site, /rennes/i

  job = post :job, :on => rennes do |job|
    job.name = "Hello Worl"
    job.resources = "nodes=2"
    job.script = "sleep 3600"
  end
  
  job.wait(:timeout => 5.min) do |job|
    job['status'] == 'running'
  end
  
  deployment = post :deployment, :on => rennes do |dep|
    dep.nodes = job['assigned_nodes']
  end
  
  poll deployment

Grammar[:job] = "http://whatever.com/job"
Grammar[:site] = "http://whatever.com/site"

root.collection(:site).each do |site|
  site.collection(:job).each do |job|
    site.get(
  end
end

root.sites

def site(name)
  search(:rel => ["site", "collection"]).find{|item| item["name"] =~ /rennes/i }
end

def job(id)
  search(:rel => ["job", "collection"]).find{|item| item["id"] == id }
end

site("rennes").job(1234) do |job|
  delete job
end

site("rennes").job

search(:rel => ["site", "collection"])
search(:rel => ["job", "collection"]) do |jobs|
  
end

find(:rel => http://whatever.com/jobs) do |jobs|
  jobs.post()
end


OPTIONS /

Allow: GET

GET /
Link: /jobs, rel="collection http://whatever.com/jobs"
Link: /deployments

OPTIONS




Example: GOAL: ordering 2 products and paying

If no error callback, will silently ignore the error, add a message in the log, and return nil

    products_to_buy = []
    
    Declare StateMachine:
      states, transitions, events, conditions
    
      trans :root, :products, :empty
      trans :empty, :selection, :not_empty
      state :not_empty do
        on_entry :count_products_selected
        event :not_full_yet, :not_empty
        event :full, :checkout
      end
      trans :not_empty, :selection, :not_empty
      trans :not_empty, :removal, :empty, :condition => {only 1}
      trans :not_empty, :removal, :not_empty, :condition => {>1}
      trans :not_empty, :checkout, :order
      trans :not_empty, :cancellation, :empty
      trans :order, :payment, :paid
      trans :order, :cancellation, :canceled
      
    class Engine
      def select(name)
        
      end
    end
    
    products = transition(:root, :products)
    products_to_buy << transition(:products, :find) || transition(:products, :search)
    products_to_buy << transition(:products, :find) || transition(:products, :search)
    if products.compact.length == 2
      transition(:root, :orders)
      transition(:orders, :submit)
      products.each do |product|
        transition(_, :put)
      end
    else
      fail
    end
    


    products = []
    root     = Restfully['https://amazon.com']

    root.load(:success => lambda{|landing|
      if landing.respond_to?(:products)
        products = landing.products
        if products.respond_to?(:search)
          products.search(:query => {:q => "dvd"}, :success => &add_product_to_cart)
        else
      elsif
    })
    
    
    transition(root, :load, {
     :success => lambda{ |response| 
       transition(response, :products, {
         :success => lambda{|response|  
           if response.respond_to?(:search)
           transition(response, :search, :query => {:q => "dvd"})
           products << response.find{|item|
             item['name'] =~ /dvd/
           }
         },
         :error => lambda{|respomse| fail("Cannot go further")}
       })
     },
     :error => lambda{ fail("Cannot go further") }
    }




    sdfsdfs
