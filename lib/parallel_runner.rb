# -*- coding: utf-8 -*-
require 'thread'

module ParallelRunner
  def self.each(object, concurency = 10, qsize = nil, &block)
    q = qsize ? SizedQueue.new(qsize) : Queue.new
    producer = Thread.start(q, concurency) do |pq, pc|
      if object.instance_of? Hash
        object.each {|key, value| pq.enq([[key, value], true])}
      else
        object.each_with_index {|value, index| pq.enq([[value, index], true])}
      end
      pc.times{pq.enq([nil, false])}
    end
    workers = []
    concurency.times do
      workers << Thread.start(q) do |wq|
        elem, flg = wq.deq
        while flg
          block.call(elem[0], elem[1])
          elem, flg = wq.deq
        end
      end
    end
    producer.join
    workers.each{|w| w.join}
  end
end

module Enumerable
  def each_parallel(concurency = 10, qsize = nil, &block)
    ParallelRunner.each(self, concurency, qsize, &block)
  end
end
