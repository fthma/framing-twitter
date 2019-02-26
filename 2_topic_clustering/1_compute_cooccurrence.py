#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
from collections import Counter
import numpy as np
from scipy import sparse
import operator
import random
import nltk
sno = nltk.stem.SnowballStemmer('english')

# Since there is a huge data size disparity among different events, if we use all tweets
# from all events when training word embeddings, the word representations will be skewed
# towards representing the usage of words in larger events. Therefore, we sample a subset
# of tweets instead when computing the co-occurrence matrix of words.
SAMPLE_SIZE = 50000

DATA_DIR = '../data/'
TWEET_DIR = '../data/tweets/'
events = open(DATA_DIR + 'event_names.txt', 'r').read().splitlines()
vocab = open(DATA_DIR + 'joint_vocab.txt', 'r').read().splitlines()
word2idx = {v: i for i, v in enumerate(vocab)}
vocab_set = set(vocab)
print(events)
print(len(vocab))

def get_coocc(tweets, word2idx):
    coocc = np.zeros((len(word2idx), len(word2idx)))
    for j, t in enumerate(tweets):
        tweet = t.split()[:100]  # set the max length to 100 tokens
        word_counts = Counter(tweet)
        bow_sorted = sorted(word_counts.items(), key=operator.itemgetter(1), reverse=True)
        for i, (word, count1) in enumerate(bow_sorted):
            for (context, count2) in bow_sorted[i:]:
                coocc[word2idx[word], word2idx[context]] += count1
                if context != word:
                    coocc[word2idx[context], word2idx[word]] += count1
        if j % 100000 == 0:
            print(tweet)
            print(j)
    return coocc

tweets = []
for event in events:
    with open(TWEET_DIR + event + '/' + event + '_cleaned_text.txt', 'r') as f:
        lines = f.read().splitlines()
        tweets.extend([lines[i] for i in sorted(random.sample(range(len(lines)), min(SAMPLE_SIZE, len(lines))))])
coocc = sparse.csr_matrix(get_coocc(tweets, word2idx))

print('Saving...')
sparse.save_npz(DATA_DIR + 'glove_cooccurrence.npz', coocc)

